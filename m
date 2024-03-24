Return-Path: <linux-kernel+bounces-113617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519678885BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067B2287DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186661D2A80;
	Sun, 24 Mar 2024 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4Tq0mDV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31813763FE;
	Sun, 24 Mar 2024 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320452; cv=none; b=AeMQXWK0q1ZM/zhZ2n9ZURMGVPrgMC/2rCgYiALQ/VaxdXlq/akOpXsK59HTlTxp5tNpf6KBWYafB+MtreqeJNT9qdzknttQ/5fCqAFHEHXEf53Jwo6Q2/h37KaP2OXdEZKhl9Bq0h1iZ8njkII4/QW15TPqjy/1Ls31SOmbGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320452; c=relaxed/simple;
	bh=fAometgkYT+8afRTn5I8qtc/WQf0RndWwBfG1rn1ejA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgXRUT7hfcCsnbtefU2N0TNHGCrsx5QniS5n4YtpSZRCXwh9G9OvUaVwTZmTc/RRg9Gio3K0O+sPxo9Ls/yilXKtcjAr8H1AWEF+Bs2A+9frliJsK5nCgKWT0MCQb6NhZn0P55soPJxIHQcSX10Sw0eAzP7ol7Y0jJTrDTuIuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4Tq0mDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E07CC43390;
	Sun, 24 Mar 2024 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320452;
	bh=fAometgkYT+8afRTn5I8qtc/WQf0RndWwBfG1rn1ejA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4Tq0mDVX/zRiC4qigd7YnjjTjOlMcS9yOgVyhwaLjpEFFlIvtRo3Y/woIxsJ5N3S
	 SiRBdFzEs3/8o7EHmVYT4obYxQ6vMuynqNxua0shtml/8WZHydokKAsEzj8MTy2uwW
	 L7gl8NmfOiW+clZgzmaS/Pi4VTFdrda76YBT3f+nut8DhjykAiHCkwrs5Saxmouzal
	 qCYd4a8suZ+xxrrTNpPUUL3qNkfyWzzrc2xdnXuoyymKaQfXlGyfuMdkfNl0bb+7p5
	 phpNi+oa3jk51McERZ8T7zYyLdE0Cltc/0qzpD08eAVmn5mI62rZLMN6HhN1RgNc3C
	 VtlS3+fu7dIpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 010/713] selftests: openvswitch: Add validation for the recursion test
Date: Sun, 24 Mar 2024 18:35:36 -0400
Message-ID: <20240324224720.1345309-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Aaron Conole <aconole@redhat.com>

[ Upstream commit bd128f62c365504e1268dc09fcccdfb1f091e93a ]

Add a test case into the netlink checks that will show the number of
nested action recursions won't exceed 16.  Going to 17 on a small
clone call isn't enough to exhaust the stack on (most) systems, so
it should be safe to run even on systems that don't have the fix
applied.

Signed-off-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240207132416.1488485-3-aconole@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 13 ++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 71 +++++++++++++++----
 2 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index f8499d4c87f3f..36e40256ab92a 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -502,7 +502,20 @@ test_netlink_checks () {
 	    wc -l) == 2 ] || \
 	      return 1
 
+	info "Checking clone depth"
 	ERR_MSG="Flow actions may not be safe on all matching packets"
+	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
+	ovs_add_flow "test_netlink_checks" nv0 \
+		'in_port(1),eth(),eth_type(0x800),ipv4()' \
+		'clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(drop)))))))))))))))))' \
+		>/dev/null 2>&1 && return 1
+	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
+
+	if [ "$PRE_TEST" == "$POST_TEST" ]; then
+		info "failed - clone depth too large"
+		return 1
+	fi
+
 	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
 	ovs_add_flow "test_netlink_checks" nv0 \
 		'in_port(1),eth(),eth_type(0x0806),arp()' 'drop(0),2' \
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index b97e621face95..5e0e539a323d5 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -299,7 +299,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_PUSH_NSH", "none"),
         ("OVS_ACTION_ATTR_POP_NSH", "flag"),
         ("OVS_ACTION_ATTR_METER", "none"),
-        ("OVS_ACTION_ATTR_CLONE", "none"),
+        ("OVS_ACTION_ATTR_CLONE", "recursive"),
         ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
         ("OVS_ACTION_ATTR_DEC_TTL", "none"),
@@ -465,29 +465,42 @@ class ovsactions(nla):
                     print_str += "pop_mpls"
             else:
                 datum = self.get_attr(field[0])
-                print_str += datum.dpstr(more)
+                if field[0] == "OVS_ACTION_ATTR_CLONE":
+                    print_str += "clone("
+                    print_str += datum.dpstr(more)
+                    print_str += ")"
+                else:
+                    print_str += datum.dpstr(more)
 
         return print_str
 
     def parse(self, actstr):
+        totallen = len(actstr)
         while len(actstr) != 0:
             parsed = False
+            parencount = 0
             if actstr.startswith("drop"):
                 # If no reason is provided, the implicit drop is used (i.e no
                 # action). If some reason is given, an explicit action is used.
-                actstr, reason = parse_extract_field(
-                    actstr,
-                    "drop(",
-                    "([0-9]+)",
-                    lambda x: int(x, 0),
-                    False,
-                    None,
-                )
+                reason = None
+                if actstr.startswith("drop("):
+                    parencount += 1
+
+                    actstr, reason = parse_extract_field(
+                        actstr,
+                        "drop(",
+                        "([0-9]+)",
+                        lambda x: int(x, 0),
+                        False,
+                        None,
+                    )
+
                 if reason is not None:
                     self["attrs"].append(["OVS_ACTION_ATTR_DROP", reason])
                     parsed = True
                 else:
-                    return
+                    actstr = actstr[len("drop"): ]
+                    return (totallen - len(actstr))
 
             elif parse_starts_block(actstr, "^(\d+)", False, True):
                 actstr, output = parse_extract_field(
@@ -504,6 +517,7 @@ class ovsactions(nla):
                     False,
                     0,
                 )
+                parencount += 1
                 self["attrs"].append(["OVS_ACTION_ATTR_RECIRC", recircid])
                 parsed = True
 
@@ -516,12 +530,22 @@ class ovsactions(nla):
 
             for flat_act in parse_flat_map:
                 if parse_starts_block(actstr, flat_act[0], False):
-                    actstr += len(flat_act[0])
+                    actstr = actstr[len(flat_act[0]):]
                     self["attrs"].append([flat_act[1]])
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
-            if parse_starts_block(actstr, "ct(", False):
+            if parse_starts_block(actstr, "clone(", False):
+                parencount += 1
+                subacts = ovsactions()
+                actstr = actstr[len("clone("):]
+                parsedLen = subacts.parse(actstr)
+                lst = []
+                self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
+                actstr = actstr[parsedLen:]
+                parsed = True
+            elif parse_starts_block(actstr, "ct(", False):
+                parencount += 1
                 actstr = actstr[len("ct(") :]
                 ctact = ovsactions.ctact()
 
@@ -553,6 +577,7 @@ class ovsactions(nla):
                         natact = ovsactions.ctact.natattr()
 
                         if actstr.startswith("("):
+                            parencount += 1
                             t = None
                             actstr = actstr[1:]
                             if actstr.startswith("src"):
@@ -607,15 +632,29 @@ class ovsactions(nla):
                                     actstr = actstr[strspn(actstr, ", ") :]
 
                         ctact["attrs"].append(["OVS_CT_ATTR_NAT", natact])
-                        actstr = actstr[strspn(actstr, ",) ") :]
+                        actstr = actstr[strspn(actstr, ", ") :]
 
                 self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
                 parsed = True
 
-            actstr = actstr[strspn(actstr, "), ") :]
+            actstr = actstr[strspn(actstr, ", ") :]
+            while parencount > 0:
+                parencount -= 1
+                actstr = actstr[strspn(actstr, " "):]
+                if len(actstr) and actstr[0] != ")":
+                    raise ValueError("Action str: '%s' unbalanced" % actstr)
+                actstr = actstr[1:]
+
+            if len(actstr) and actstr[0] == ")":
+                return (totallen - len(actstr))
+
+            actstr = actstr[strspn(actstr, ", ") :]
+
             if not parsed:
                 raise ValueError("Action str: '%s' not supported" % actstr)
 
+        return (totallen - len(actstr))
+
 
 class ovskey(nla):
     nla_flags = NLA_F_NESTED
@@ -2111,6 +2150,8 @@ def main(argv):
     ovsflow = OvsFlow()
     ndb = NDB()
 
+    sys.setrecursionlimit(100000)
+
     if hasattr(args, "showdp"):
         found = False
         for iface in ndb.interfaces:
-- 
2.43.0


