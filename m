Return-Path: <linux-kernel+bounces-151604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5A8AB104
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F441C22C75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C43E12FF77;
	Fri, 19 Apr 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuRCUrVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1112FB3B;
	Fri, 19 Apr 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538084; cv=none; b=UYrACQVR60ftJgqeWR8tFDAx51qzzdAmaquY3XJqoM5yrll3uiBxfgWqiok5AFPaxJIQd0vZSlmIsZq9cvP6Q3Sxi09oY2wE5+OGS8Q2I91Q7nsexEMNwzkJcEas6/sfEOszosWVKEfyg2S26OMMdE6RlDIkPiSgtR4CbWnyvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538084; c=relaxed/simple;
	bh=/LAcqzfMdnZvAZXucskSQU6PgrY6Yvip45QZyOx1xEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UN9nNF2+BuBA39f5jfk2NoOKr3YrNqsF2uHaddiezgxOl34T4RPrKfo03VQ4YPOJc4nB02VF3kab0i9jWVm9c3gNjfFKKpj4K/ZhQqs//lvrwnYA+oz0bOUF0m8WyS+jJnX+6xWubdwPQlRdt+uE7o1deq3WFGF4OaEf+UGrip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuRCUrVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD80C32781;
	Fri, 19 Apr 2024 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713538083;
	bh=/LAcqzfMdnZvAZXucskSQU6PgrY6Yvip45QZyOx1xEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BuRCUrVGAEZpoS7MUCJYTtXvL7w0JOBGu4+4DTrXALwT9tPj80MKg/M3EvvWAnYIH
	 C+GDP29BK06kDF/XsfpueUAWVUJtOc/0QeD7a8bhRTjKBt0QycpKGYGFLg4+ULaNR+
	 FVC5mU+g89mesb/KowzjOoPoQmnhlOUG/sR8jR4XvCtxLGZCXixz97tsBxqP6rSwJ1
	 rMTIwaVLjTmRNLIu1R5YmSmIjyx6Gd443PuIsCrIA0aBChDmD0E7pFH+mPNiKfj5Yh
	 SdLC6eRZAOL6AHqLneNiV4+ZuViPU+Xyu45rVAfnJaOB98UsmrJc3wzQZCD7Z05mep
	 TLvc9BFWJEGSA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 19 Apr 2024 16:47:53 +0200
Subject: [PATCH 3/3] HID: bpf: lazy load the hid_tail_call entrypoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-hid_bpf_lazy_skel-v1-3-9210bcd4b61c@kernel.org>
References: <20240419-hid_bpf_lazy_skel-v1-0-9210bcd4b61c@kernel.org>
In-Reply-To: <20240419-hid_bpf_lazy_skel-v1-0-9210bcd4b61c@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713538077; l=1849;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=/LAcqzfMdnZvAZXucskSQU6PgrY6Yvip45QZyOx1xEw=;
 b=lu1EPuWLunmFB5BNa2UVk8h2iuEuTCLoaDtaCSaoBiBBjalZ7wijs3fNFa7n0hhBxBbUGPHYf
 OY6tl7r6sNmDz1auSPrxNwagDSn5LNOpnYP/iXkwqf6hAFRP908s1ck
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that on some professional distributions, with things partly
backported (not sure exactly), loading this kernel bpf program might
enter a RCU task deadlock.

Given that it actually does not make sense to preload this in every
environment, we can lazy load it the first time we need it, i.e. the
first time the kfunc hid_bpf_attach_prog() is called.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c  | 6 ------
 drivers/hid/bpf/hid_bpf_jmp_table.c | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 10289f44d0cc..1946ad962d03 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -642,12 +642,6 @@ static int __init hid_bpf_init(void)
 		return 0;
 	}
 
-	err = hid_bpf_preload_skel();
-	if (err) {
-		pr_warn("error while preloading HID BPF dispatcher: %d", err);
-		return 0;
-	}
-
 	/* register tracing kfuncs after we are sure we can load our preloaded bpf program */
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
 	if (err) {
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index 301ac79db241..75ce215f0ada 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -404,6 +404,13 @@ __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
 
 	mutex_lock(&hid_bpf_attach_lock);
 
+	if (!jmp_table.map) {
+		err = hid_bpf_preload_skel();
+		WARN_ONCE(err, "error while preloading HID BPF dispatcher: %d", err);
+		if (err)
+			goto err_unlock;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_USER);
 	if (!link) {
 		err = -ENOMEM;

-- 
2.44.0


