Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC97F6BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjKXFuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXFur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:50:47 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287F2D6F;
        Thu, 23 Nov 2023 21:50:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vx0Q5lf_1700805048;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vx0Q5lf_1700805048)
          by smtp.aliyun-inc.com;
          Fri, 24 Nov 2023 13:50:49 +0800
Date:   Fri, 24 Nov 2023 13:50:47 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        corbet@lwn.net, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/smc: add sysctl for max links per lgr
 for SMC-R v2.1
Message-ID: <20231124055047.GJ3323@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
 <20231122135258.38746-2-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122135258.38746-2-guangguan.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:52:57PM +0800, Guangguan Wang wrote:
>Add a new sysctl: net.smc.smcr_max_links_per_lgr, which is
>used to control the preferred max links per lgr for SMC-R
>v2.1. The default value of this sysctl is 2, and the acceptable
>value ranges from 1 to 2.
>
>Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

LGTM

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> Documentation/networking/smc-sysctl.rst |  8 ++++++++
> include/net/netns/smc.h                 |  1 +
> net/smc/af_smc.c                        |  2 +-
> net/smc/smc_clc.c                       | 10 +++++++---
> net/smc/smc_clc.h                       |  3 ++-
> net/smc/smc_sysctl.c                    | 12 ++++++++++++
> net/smc/smc_sysctl.h                    |  1 +
> 7 files changed, 32 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
>index 769149d98773..c6ef86ef4c4f 100644
>--- a/Documentation/networking/smc-sysctl.rst
>+++ b/Documentation/networking/smc-sysctl.rst
>@@ -57,3 +57,11 @@ rmem - INTEGER
> 	only allowed 512KiB for SMC-R and 1MiB for SMC-D.
> 
> 	Default: 64KiB
>+
>+smcr_max_links_per_lgr - INTEGER
>+	Controls the max number of links can be added to a SMC-R link group. Notice that
>+	the actual number of the links added to a SMC-R link group depends on the number
>+	of RDMA devices exist in the system. The acceptable value ranges from 1 to 2. Only
>+	for SMC-R v2.1 and later.
>+
>+	Default: 2
>diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
>index 582212ada3ba..da7023587824 100644
>--- a/include/net/netns/smc.h
>+++ b/include/net/netns/smc.h
>@@ -22,5 +22,6 @@ struct netns_smc {
> 	int				sysctl_smcr_testlink_time;
> 	int				sysctl_wmem;
> 	int				sysctl_rmem;
>+	int				sysctl_max_links_per_lgr;
> };
> #endif
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index da97f946b79b..f8da484efe90 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -2457,7 +2457,7 @@ static void smc_listen_work(struct work_struct *work)
> 	if (rc)
> 		goto out_decl;
> 
>-	rc = smc_clc_srv_v2x_features_validate(pclc, ini);
>+	rc = smc_clc_srv_v2x_features_validate(new_smc, pclc, ini);
> 	if (rc)
> 		goto out_decl;
> 
>diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>index 8deb46c28f1d..1f87c8895a27 100644
>--- a/net/smc/smc_clc.c
>+++ b/net/smc/smc_clc.c
>@@ -824,6 +824,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
> 	struct smc_clc_smcd_gid_chid *gidchids;
> 	struct smc_clc_msg_proposal_area *pclc;
> 	struct smc_clc_ipv6_prefix *ipv6_prfx;
>+	struct net *net = sock_net(&smc->sk);
> 	struct smc_clc_v2_extension *v2_ext;
> 	struct smc_clc_msg_smcd *pclc_smcd;
> 	struct smc_clc_msg_trail *trl;
>@@ -944,7 +945,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
> 	if (smcr_indicated(ini->smc_type_v2)) {
> 		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
> 		v2_ext->max_conns = SMC_CONN_PER_LGR_PREFER;
>-		v2_ext->max_links = SMC_LINKS_PER_LGR_MAX_PREFER;
>+		v2_ext->max_links = net->smc.sysctl_max_links_per_lgr;
> 	}
> 
> 	pclc_base->hdr.length = htons(plen);
>@@ -1171,10 +1172,12 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
> 	return len > 0 ? 0 : len;
> }
> 
>-int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>+int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
>+				      struct smc_clc_msg_proposal *pclc,
> 				      struct smc_init_info *ini)
> {
> 	struct smc_clc_v2_extension *pclc_v2_ext;
>+	struct net *net = sock_net(&smc->sk);
> 
> 	ini->max_conns = SMC_CONN_PER_LGR_MAX;
> 	ini->max_links = SMC_LINKS_ADD_LNK_MAX;
>@@ -1192,7 +1195,8 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
> 		if (ini->max_conns < SMC_CONN_PER_LGR_MIN)
> 			return SMC_CLC_DECL_MAXCONNERR;
> 
>-		ini->max_links = min_t(u8, pclc_v2_ext->max_links, SMC_LINKS_PER_LGR_MAX_PREFER);
>+		ini->max_links = min_t(u8, pclc_v2_ext->max_links,
>+				       net->smc.sysctl_max_links_per_lgr);
> 		if (ini->max_links < SMC_LINKS_ADD_LNK_MIN)
> 			return SMC_CLC_DECL_MAXLINKERR;
> 	}
>diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>index c5c8e7db775a..89b258cedffe 100644
>--- a/net/smc/smc_clc.h
>+++ b/net/smc/smc_clc.h
>@@ -422,7 +422,8 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
> 			 u8 version, u8 *eid, struct smc_init_info *ini);
> int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
> 			u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
>-int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>+int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
>+				      struct smc_clc_msg_proposal *pclc,
> 				      struct smc_init_info *ini);
> int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
> 				       struct smc_init_info *ini);
>diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
>index 5cbc18c6e62b..3e9bb921e40a 100644
>--- a/net/smc/smc_sysctl.c
>+++ b/net/smc/smc_sysctl.c
>@@ -25,6 +25,8 @@ static int max_sndbuf = INT_MAX / 2;
> static int max_rcvbuf = INT_MAX / 2;
> static const int net_smc_wmem_init = (64 * 1024);
> static const int net_smc_rmem_init = (64 * 1024);
>+static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
>+static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
> 
> static struct ctl_table smc_table[] = {
> 	{
>@@ -68,6 +70,15 @@ static struct ctl_table smc_table[] = {
> 		.extra1		= &min_rcvbuf,
> 		.extra2		= &max_rcvbuf,
> 	},
>+	{
>+		.procname	= "smcr_max_links_per_lgr",
>+		.data		= &init_net.smc.sysctl_max_links_per_lgr,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_minmax,
>+		.extra1		= &links_per_lgr_min,
>+		.extra2		= &links_per_lgr_max,
>+	},
> 	{  }
> };
> 
>@@ -97,6 +108,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
> 	net->smc.sysctl_smcr_testlink_time = SMC_LLC_TESTLINK_DEFAULT_TIME;
> 	WRITE_ONCE(net->smc.sysctl_wmem, net_smc_wmem_init);
> 	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>+	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
> 
> 	return 0;
> 
>diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
>index 0becc11bd2f4..5783dd7575dd 100644
>--- a/net/smc/smc_sysctl.h
>+++ b/net/smc/smc_sysctl.h
>@@ -23,6 +23,7 @@ void __net_exit smc_sysctl_net_exit(struct net *net);
> static inline int smc_sysctl_net_init(struct net *net)
> {
> 	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>+	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
> 	return 0;
> }
> 
>-- 
>2.24.3 (Apple Git-128)
