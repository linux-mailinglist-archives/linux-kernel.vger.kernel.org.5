Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68D07F9EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjK0Lu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjK0Lu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:50:26 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 03:50:29 PST
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC1101;
        Mon, 27 Nov 2023 03:50:29 -0800 (PST)
X-SCHWARZ-TO: linux-kernel@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 coreteam@netfilter.org, davem@davemloft.net, netfilter-devel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, fw@strlen.de
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from unknown (HELO kernel-bug-kernel-bug) ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 11:49:24 +0000
Date:   Mon, 27 Nov 2023 11:49:16 +0000
From:   Felix Huettner <felix.huettner@mail.schwarz>
To:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shuah@kernel.org, luca.czesla@mail.schwarz,
        max.lamprecht@mail.schwarz
Subject: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

conntrack zones are heavily used by tools like openvswitch to run
multiple virtual "routers" on a single machine. In this context each
conntrack zone matches to a single router, thereby preventing
overlapping IPs from becoming issues.
In these systems it is common to operate on all conntrack entries of a
given zone, e.g. to delete them when a router is deleted. Previously this
required these tools to dump the full conntrack table and filter out the
relevant entries in userspace potentially causing performance issues.

To do this we reuse the existing CTA_ZONE attribute. This was previous
parsed but not used during dump and flush requests. Now if CTA_ZONE is
set we filter these operations based on the provided zone.
However this means that users that previously passed CTA_ZONE will
experience a difference in functionality.

Alternatively CTA_FILTER could have been used for the same
functionality. However it is not yet supported during flush requests and
is only available when using AF_INET or AF_INET6.

Co-developed-by: Luca Czesla <luca.czesla@mail.schwarz>
Signed-off-by: Luca Czesla <luca.czesla@mail.schwarz>
Co-developed-by: Max Lamprecht <max.lamprecht@mail.schwarz>
Signed-off-by: Max Lamprecht <max.lamprecht@mail.schwarz>
Signed-off-by: Felix Huettner <felix.huettner@mail.schwarz>
---
 net/netfilter/nf_conntrack_netlink.c          |  15 +-
 tools/testing/selftests/netfilter/.gitignore  |   2 +
 tools/testing/selftests/netfilter/Makefile    |   3 +-
 .../netfilter/conntrack_dump_flush.c          | 430 ++++++++++++++++++
 4 files changed, 444 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/netfilter/conntrack_dump_flush.c

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index fb0ae15e96df..4e9133f61251 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -992,13 +992,13 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 	if (err)
 		goto err_filter;
 
+	err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
+	if (err < 0)
+		goto err_filter;
+
 	if (!cda[CTA_FILTER])
 		return filter;
 
-	err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
-	if (err < 0)
-		goto err_filter;
-
 	err = ctnetlink_parse_filter(cda[CTA_FILTER], filter);
 	if (err < 0)
 		goto err_filter;
@@ -1043,7 +1043,8 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 
 static bool ctnetlink_needs_filter(u8 family, const struct nlattr * const *cda)
 {
-	return family || cda[CTA_MARK] || cda[CTA_FILTER] || cda[CTA_STATUS];
+	return family || cda[CTA_MARK] || cda[CTA_FILTER] || cda[CTA_STATUS] ||
+		cda[CTA_ZONE];
 }
 
 static int ctnetlink_start(struct netlink_callback *cb)
@@ -1148,6 +1149,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 	if (filter->family && nf_ct_l3num(ct) != filter->family)
 		goto ignore_entry;
 
+	if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
+	    !nf_ct_zone_equal_any(ct, &filter->zone))
+		goto ignore_entry;
+
 	if (filter->orig_flags) {
 		tuple = nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
 		if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
diff --git a/tools/testing/selftests/netfilter/.gitignore b/tools/testing/selftests/netfilter/.gitignore
index 4b2928e1c19d..c2229b3e40d4 100644
--- a/tools/testing/selftests/netfilter/.gitignore
+++ b/tools/testing/selftests/netfilter/.gitignore
@@ -2,3 +2,5 @@
 nf-queue
 connect_close
 audit_logread
+conntrack_dump_flush
+sctp_collision
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index bced422b78f7..db27153eb4a0 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -14,6 +14,7 @@ HOSTPKG_CONFIG := pkg-config
 CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
 LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
-TEST_GEN_FILES =  nf-queue connect_close audit_logread sctp_collision
+TEST_GEN_FILES =  nf-queue connect_close audit_logread sctp_collision \
+	conntrack_dump_flush
 
 include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
new file mode 100644
index 000000000000..f18c6db13bbf
--- /dev/null
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <time.h>
+#include <libmnl/libmnl.h>
+#include <netinet/ip.h>
+
+#include <linux/netlink.h>
+#include <linux/netfilter/nfnetlink.h>
+#include <linux/netfilter/nfnetlink_conntrack.h>
+#include <linux/netfilter/nf_conntrack_tcp.h>
+#include "../kselftest_harness.h"
+
+#define TEST_ZONE_ID 123
+#define CTA_FILTER_F_CTA_TUPLE_ZONE (1 << 2)
+
+static int reply_counter;
+
+static int build_cta_tuple_v4(struct nlmsghdr *nlh, int type,
+			      uint32_t src_ip, uint32_t dst_ip,
+			      uint16_t src_port, uint16_t dst_port)
+{
+	struct nlattr *nest, *nest_ip, *nest_proto;
+
+	nest = mnl_attr_nest_start(nlh, type);
+	if (!nest)
+		return -1;
+
+	nest_ip = mnl_attr_nest_start(nlh, CTA_TUPLE_IP);
+	if (!nest_ip)
+		return -1;
+	mnl_attr_put_u32(nlh, CTA_IP_V4_SRC, src_ip);
+	mnl_attr_put_u32(nlh, CTA_IP_V4_DST, dst_ip);
+	mnl_attr_nest_end(nlh, nest_ip);
+
+	nest_proto = mnl_attr_nest_start(nlh, CTA_TUPLE_PROTO);
+	if (!nest_proto)
+		return -1;
+	mnl_attr_put_u8(nlh, CTA_PROTO_NUM, 6);
+	mnl_attr_put_u16(nlh, CTA_PROTO_SRC_PORT, htons(src_port));
+	mnl_attr_put_u16(nlh, CTA_PROTO_DST_PORT, htons(dst_port));
+	mnl_attr_nest_end(nlh, nest_proto);
+
+	mnl_attr_nest_end(nlh, nest);
+}
+
+static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
+			      struct in6_addr src_ip, struct in6_addr dst_ip,
+			      uint16_t src_port, uint16_t dst_port)
+{
+	struct nlattr *nest, *nest_ip, *nest_proto;
+
+	nest = mnl_attr_nest_start(nlh, type);
+	if (!nest)
+		return -1;
+
+	nest_ip = mnl_attr_nest_start(nlh, CTA_TUPLE_IP);
+	if (!nest_ip)
+		return -1;
+	mnl_attr_put(nlh, CTA_IP_V6_SRC, sizeof(struct in6_addr), &src_ip);
+	mnl_attr_put(nlh, CTA_IP_V6_DST, sizeof(struct in6_addr), &dst_ip);
+	mnl_attr_nest_end(nlh, nest_ip);
+
+	nest_proto = mnl_attr_nest_start(nlh, CTA_TUPLE_PROTO);
+	if (!nest_proto)
+		return -1;
+	mnl_attr_put_u8(nlh, CTA_PROTO_NUM, 6);
+	mnl_attr_put_u16(nlh, CTA_PROTO_SRC_PORT, htons(src_port));
+	mnl_attr_put_u16(nlh, CTA_PROTO_DST_PORT, htons(dst_port));
+	mnl_attr_nest_end(nlh, nest_proto);
+
+	mnl_attr_nest_end(nlh, nest);
+}
+
+static int build_cta_proto(struct nlmsghdr *nlh)
+{
+	struct nlattr *nest, *nest_proto;
+
+	nest = mnl_attr_nest_start(nlh, CTA_PROTOINFO);
+	if (!nest)
+		return -1;
+
+	nest_proto = mnl_attr_nest_start(nlh, CTA_PROTOINFO_TCP);
+	if (!nest_proto)
+		return -1;
+	mnl_attr_put_u8(nlh, CTA_PROTOINFO_TCP_STATE, TCP_CONNTRACK_ESTABLISHED);
+	mnl_attr_put_u16(nlh, CTA_PROTOINFO_TCP_FLAGS_ORIGINAL, 0x0a0a);
+	mnl_attr_put_u16(nlh, CTA_PROTOINFO_TCP_FLAGS_REPLY, 0x0a0a);
+	mnl_attr_nest_end(nlh, nest_proto);
+
+	mnl_attr_nest_end(nlh, nest);
+}
+
+static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
+				 uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *rplnlh;
+	unsigned int portid;
+	int err, ret;
+
+	portid = mnl_socket_get_portid(sock);
+
+	ret = build_cta_proto(nlh);
+	if (ret < 0) {
+		perror("build_cta_proto");
+		return -1;
+	}
+	mnl_attr_put_u32(nlh, CTA_TIMEOUT, htonl(20000));
+	mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+	if (mnl_socket_sendto(sock, nlh, nlh->nlmsg_len) < 0) {
+		perror("mnl_socket_sendto");
+		return -1;
+	}
+
+	ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	if (ret < 0) {
+		perror("mnl_socket_recvfrom");
+		return ret;
+	}
+
+	ret = mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid, NULL, NULL);
+	if (ret < 0) {
+		if (errno == EEXIST) {
+			/* The entries are probably still there from a previous
+			 * run. So we are good
+			 */
+			return 0;
+		}
+		perror("mnl_cb_run");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int conntrack_data_generate_v4(struct mnl_socket *sock, uint32_t src_ip,
+				      uint32_t dst_ip, uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	struct nfgenmsg *nfh;
+	int ret;
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type = (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_NEW;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE |
+			   NLM_F_ACK | NLM_F_EXCL;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_INET;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	ret = build_cta_tuple_v4(nlh, CTA_TUPLE_ORIG, src_ip, dst_ip, 12345, 443);
+	if (ret < 0) {
+		perror("build_cta_tuple_v4");
+		return ret;
+	}
+	ret = build_cta_tuple_v4(nlh, CTA_TUPLE_REPLY, dst_ip, src_ip, 443, 12345);
+	if (ret < 0) {
+		perror("build_cta_tuple_v4");
+		return ret;
+	}
+	return conntrack_data_insert(sock, nlh, zone);
+}
+
+static int conntrack_data_generate_v6(struct mnl_socket *sock,
+				      struct in6_addr src_ip,
+				      struct in6_addr dst_ip,
+				      uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	struct nfgenmsg *nfh;
+	int ret;
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type = (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_NEW;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE |
+			   NLM_F_ACK | NLM_F_EXCL;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_INET6;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	ret = build_cta_tuple_v6(nlh, CTA_TUPLE_ORIG, src_ip, dst_ip,
+				 12345, 443);
+	if (ret < 0) {
+		perror("build_cta_tuple_v6");
+		return ret;
+	}
+	ret = build_cta_tuple_v6(nlh, CTA_TUPLE_REPLY, dst_ip, src_ip,
+				 12345, 443);
+	if (ret < 0) {
+		perror("build_cta_tuple_v6");
+		return ret;
+	}
+	return conntrack_data_insert(sock, nlh, zone);
+}
+
+static int count_entries(const struct nlmsghdr *nlh, void *data)
+{
+	reply_counter++;
+}
+
+static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh, *rplnlh;
+	struct nfgenmsg *nfh;
+	struct nlattr *nest;
+	unsigned int portid;
+	int err, ret;
+
+	portid = mnl_socket_get_portid(sock);
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type	= (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_GET;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_UNSPEC;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+	ret = mnl_socket_sendto(sock, nlh, nlh->nlmsg_len);
+	if (ret < 0) {
+		perror("mnl_socket_sendto");
+		return ret;
+	}
+
+	reply_counter = 0;
+	ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	while (ret > 0) {
+		ret = mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid,
+				 count_entries, NULL);
+		if (ret <= MNL_CB_STOP)
+			break;
+
+		ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	}
+	if (ret < 0) {
+		perror("mnl_socket_recvfrom");
+		return ret;
+	}
+
+	return reply_counter;
+}
+
+static int conntrack_flush_zone(struct mnl_socket *sock, uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh, *rplnlh;
+	struct nfgenmsg *nfh;
+	struct nlattr *nest;
+	unsigned int portid;
+	int err, ret;
+
+	portid = mnl_socket_get_portid(sock);
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type	= (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_DELETE;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_UNSPEC;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+	ret = mnl_socket_sendto(sock, nlh, nlh->nlmsg_len);
+	if (ret < 0) {
+		perror("mnl_socket_sendto");
+		return ret;
+	}
+
+	ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	if (ret < 0) {
+		perror("mnl_socket_recvfrom");
+		return ret;
+	}
+
+	ret = mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid, NULL, NULL);
+	if (ret < 0) {
+		perror("mnl_cb_run");
+		return ret;
+	}
+
+	return 0;
+}
+
+FIXTURE(conntrack_dump_flush)
+{
+	struct mnl_socket *sock;
+};
+
+FIXTURE_SETUP(conntrack_dump_flush)
+{
+	struct in6_addr src, dst;
+	int ret;
+
+	self->sock = mnl_socket_open(NETLINK_NETFILTER);
+	if (!self->sock) {
+		perror("mnl_socket_open");
+		exit(EXIT_FAILURE);
+	}
+
+	if (mnl_socket_bind(self->sock, 0, MNL_SOCKET_AUTOPID) < 0) {
+		perror("mnl_socket_bind");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	if (ret < 0 && errno == EPERM)
+		SKIP(return, "Needs to be run as root");
+	else if (ret < 0 && errno == EOPNOTSUPP)
+		SKIP(return, "Kernel does not seem to support conntrack zones");
+
+	ret = conntrack_data_generate_v4(self->sock, 0xf0f0f0f0, 0xf1f1f1f1,
+					 TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntrack_data_generate_v4(self->sock, 0xf2f2f2f2, 0xf3f3f3f3,
+					 TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 0);
+	ret = conntrack_data_generate_v4(self->sock, 0xf4f4f4f4, 0xf5f5f5f5,
+					 TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 0);
+
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x01000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x02000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x03000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x04000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 0);
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x05000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x06000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 0);
+
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_GE(ret, 2);
+	if (ret > 2)
+		SKIP(return, "kernel does not support filtering by zone");
+}
+
+FIXTURE_TEARDOWN(conntrack_dump_flush)
+{
+}
+
+TEST_F(conntrack_dump_flush, test_dump_by_zone)
+{
+	int ret;
+
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+}
+
+TEST_F(conntrack_dump_flush, test_flush_by_zone)
+{
+	int ret;
+
+	ret = conntrack_flush_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 2);
+}
+
+TEST_HARNESS_MAIN

base-commit: aadbd27f9674d7f5457331fe0248b370d5c1f25d
-- 
2.42.1

