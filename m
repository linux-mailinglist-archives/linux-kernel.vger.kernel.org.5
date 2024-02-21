Return-Path: <linux-kernel+bounces-74658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32C85D75D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF39B242AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF9547F4A;
	Wed, 21 Feb 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiROzVRF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577247A6B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516063; cv=none; b=igPK9Gs+up/V37S7GttyCRiOcN8EpyXAOQBHizdTg5usa5rBE1RoLJ+Fa0SRElSlCoZoNmKOxPEKYTxv1owIqCeSiqXwY3gtGR0RzPaeXeBj1SmbSxjAapWlHaJyRQNom04koLRP6cwMKNnumRWLApk9QIxoCve+pmlGqKv2LAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516063; c=relaxed/simple;
	bh=JBY/mQDw97iHpPVXUG6l2AiWrlYst7bhafK07ofrkEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nduMbT4bTigxhHYu43biHG7Uxb8YWM8o2RJH7pzHAIPdw3GBTufUPYSIsSC33tZLTCCx+NAHe6Lyx/OgUhAqwfQoHDsWcEy9gH9ss0kj7Jq71fcWHHwHj1lnGBKenPsuDQs2TQ0vcowyJGBK3Twq/zB3T1ABNR69P8ukp8E+yoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiROzVRF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708516050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYtHO8q8zxUSZSdp33YY0/GjFEJNFZGA2uUDD/K00Mg=;
	b=eiROzVRFSb7HJRfejh4zKdM/6wkE7RIgnTGjMHnCecMiydzBHemKPKkgalg5/ncDdtmakU
	/vTGTdc5jWmEqbH7PIoVhBJ0Y3vGNcfZYStckEkDUhx41I7kTNC6mniBaV12FC0tF7OXPj
	nz1K9nAWC4RAJf9Ak09RGPbnRQt2YGk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-l1e2WZA9PjmHEE1vlZXNnA-1; Wed, 21 Feb 2024 06:47:29 -0500
X-MC-Unique: l1e2WZA9PjmHEE1vlZXNnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5638785A588;
	Wed, 21 Feb 2024 11:47:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87354C08496;
	Wed, 21 Feb 2024 11:47:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] selftests: mptcp: explicitly trigger the listener diag code-path
Date: Wed, 21 Feb 2024 12:46:59 +0100
Message-ID: <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
In-Reply-To: <cover.1708515908.git.pabeni@redhat.com>
References: <cover.1708515908.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The mptcp diag interface already experienced a few locking bugs
that lockdep and appropriate coverage have detected in advance.

Let's add a test-case triggering the relevant code path, to prevent
similar issues in the future.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 60a7009ce1b5..3ab584b38566 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -81,6 +81,21 @@ chk_msk_nr()
 	__chk_msk_nr "grep -c token:" "$@"
 }
 
+chk_listener_nr()
+{
+	local expected=$1
+	local msg="$2"
+
+	if [ $expected -gt 0 ] && \
+	   ! mptcp_lib_kallsyms_has "mptcp_diag_dump_listeners"; then
+		printf "%-50s%s\n" "$msg - mptcp" "[ skip ]"
+		mptcp_lib_result_skip "many listener sockets"
+	else
+		__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp"
+	fi
+	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
+}
+
 wait_msk_nr()
 {
 	local condition="grep -c token:"
@@ -279,5 +294,20 @@ flush_pids
 chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0 "many->0"
 
+chk_listener_nr 0 "no listener sockets"
+NR_SERVERS=100
+for I in $(seq 1 $NR_SERVERS); do
+	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) -l 0.0.0.0 2>&1 >/dev/null &
+	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
+done
+
+chk_listener_nr $NR_SERVERS "many listener sockets"
+
+# gracefull termination
+for I in $(seq 1 $NR_SERVERS); do
+	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 2>&1 >/dev/null
+done
+flush_pids
+
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.43.0


