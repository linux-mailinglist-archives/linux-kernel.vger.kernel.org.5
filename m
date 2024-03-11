Return-Path: <linux-kernel+bounces-99536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8428789B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718971C20C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2353807;
	Mon, 11 Mar 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r7rxotb2"
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C949F3CF6A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190052; cv=none; b=FD+n/noiG0dDAe9ow7/j/GEPApqHaktbNCOeMEMNFSfV0a9XYXpq60W3zJGoqPuaOaCws8EGH2/826xyMYP16bamkiYesqtlkDp7uwEZ4/lzcKf2mrtDwW6uWN+FFP7DFuHWuDs+GoMqLGxpxSQvizc2J1cl+bLvmLYMOOpT0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190052; c=relaxed/simple;
	bh=tSout2TqFMMn1aVNiQh1eTMMgTL81OOw9wbOBN5R21U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=K+67aXeyzgOL4laqmkjBx51I6txwT0O/A7/MFmFAWAfzqaJvBFmTFLwqI1k92N+a6sY1xeIf3dRD1T4i00tFJOJQxxXmK/vwsBaVSkj2SXd85j5otDQI+pcba1dUr2UQ49XtHAOn4z33rU7Ko+GQ65tCK/q9zuxjaTsBLyvAI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r7rxotb2; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710190043; bh=R+3yYbDK/b0o/B6YZnnajyfQUTD2GpVdBRpsPhQlXns=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=r7rxotb2Q7UefoQeogvGb/sqCFP1ozvTgiwBx/aGDMkFkmW1dKsmX8nJdD79dTSnqUdwGIQLbDM9xoptEH2z70Xq/RSYitVRziHwBjzkZTAn2Bz26VgQu26QJK+8OFMpYRUpMYYd6ymw7i2q8HgZyX2AXgSfoqotlEBpmomy2LB8ebYI0UNxQWHpHM4HyVBy6jGSS2QjmwtBWlV0k6yUjKHLK/iJ4CRVXx4ZdjEXoJcFmvp+WPHugMqQ/nhTkb5FxUE39UoKPNtsdcx66E3EwYtbU7P00Ro+4jiTTq8eT2PkHbL1ubGmxXZ9I+ePBY4cRJvoKbmkKBoX7AvMoyaU5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710190043; bh=/8tcXfGJighrM3waXPPmsADLIMO6dMC1a1lM+jLWWRK=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=PnUXH6iopAn6VVRQiSQVNmtydguMTpgtg0BVCUdLTlDNMOlg8Cz4h3o8Ohp7qSG25B+PeEWBrkezq1X0JUAxlNfCzVvkYlxm+aZ/VoJV0XVYax5r6OuT37JtsonU/8NeA2MyfcS5QR3+k10JhgoJxuk0wzWlvHFA3UMLk3PxBpPsUuE8svjoXVYvSzH6uXkfHXKf31baZaEK1PXdAeR6TgxVpWd4u5ddJK05ZQB0dkI3Eaa/Q9EW1nUCprdUTcBrZPsWzSNNlv9pF4GJSRUxWUIZdCQGpJKCKV39rauy2fUSAJtQaMLnybSYCkr7K5yrvqTgOvFeghYFsDYJw47mwg==
X-YMail-OSG: 9giBdIsVM1k2TqWuek9tZkaVKqqkQyda.X76UOnNNoALeLsguuIOSwpmj_dfaBa
 I.1M2TYfDa.tGKQZia_ImbS9D8bNUo7fJEI.NWVggAJW96r11bKugavYyPFo2OGzFxIAdZA2IJPC
 djVB4Bsz2pmLIa1rvHzBl3KnQQfjbUysB4jCIm6ZkGlb8HLMrQ55geiipbg4Ut_OwMOsYiu0u5Hw
 LI3Hp0A3GKudeilmXlMEXq5LrMoq4aDK3ehUF9Z7fueKUvuJrRKpvZ.F07UMI8LXc_HlBZSK_.an
 ZUl_nn97BcQqPI8ytPd8ldrz8TrOXVbgd0Fe25nAw_GDEDb009kryVquaZtHqiuNMu5.9IopDHSX
 RLkAF.dmWTGL28OKbkW6whqfbmVcqZB.WkW7e8MlUw7W7nDsLJnz1O2iI.noJboK4scAmEFySfkZ
 s3PwAXnQoR9VdbiRAP3.FscOaw1ghTAsUHaIqeUt3SBmov5ni2rAwqJKkcVzMqir0GS8ZL._yexN
 _pw_9QI.VPz_I6Jt8ltoLEPV12CMrH8TiXZ0ovOLVunBhICvytN7sIUL4xUlcH3BaQvlV.l8Z_qJ
 eRBTShWM7fcWJ0Lyouco04bMfZ4.QsVwON9Q.4rgvosO9YbOVS33DI0BK.5rlXxBgI44q3WqlIcy
 Jr6TM22wkVAHvD_2bzQx1h.koQVMczoYr7rFdr6QwoNcfSmZKeowftUMkUdK.ISE5yyOJGkCG1wt
 KUVh_Dh5YKGOG0Ym6wpmQgfglV9PmVQmGr4Iexio1hnm58Jd_cOu8y6s4SjCHsx8ZA_NdsgeI5_c
 nFTWt.k1vvO.rlTwiISM8s17loVSIwp1yGShFpE328PDXLvhlqeJqjwuot6y3hf0l2aE_qxm47Jm
 VKzzvpFauyCNQ1bOyEiJLuA8z5f16kT3Ebzhvq_6l8N8w8nkEot3xY5FnRpb0e3SGt8IZBnzVY2a
 2dKet55DSdDd3b3Fy4gAMzTRDVdkXvVyN3j0DeOUoJWwj3Sdx5xVxXoMUomgWUfnic.TEPa7niZu
 gtj87cTMxkVyitexEk8eGcb423LW18iL5UOoPeR10Tgg.TXdN4t.xHI3DOHE3lACmPzSNcX47hra
 seINNPL3EBmZHedhCT0xnkVs8yp_Jn3TF1dlfQe2KHAdbh5cEbbjRIv_Cect6fZvrZry9IGlBOWu
 aahhpOax9qzawV0oodVIigTS_UdS7jH0eSPXt1nBs4bzjTNQzqDgZyOpLD64R1EmT.arWTA6VuWc
 yIsHhm1hc_NvXO6H3ZwchJmd1HdnEwutMeHYLTV_QI_f6LqYfdk39lhcLzf8IFo1m3jFGHL4oydW
 9qosxyu8KlSrR.aCensB.TUAb2Eap2_WUMt0Xc5TF6qR5NEzQwTO.GCh8weYuUOvZCLSqsguw8Rs
 ybuFGw6r7u3KhIXb72HAj4Bmk3cGqAFSbiaZwZakqkOZWMWyTYuBM2Pa4o1OVsFDJKPvKNTPmuqk
 Oj9nws3HnAhM4TD2ue57vqaVcmgxG9qR1m8ub_crTgk9FqDywY_HZE3aTffR4iU.Bgj6rHrTpNOF
 7saow24jq7vTqR7xNbo1Umc0nxnQXquNvCww5JgvQz2nl0pUhnKAbeDVp0Us2cMNKrXpiMb92YdO
 WpjGXDecgKYDfMA2lf9HzjAOOe5C3Nl0CrGwixat2xjHKQKLxmJgtmUMwn41j.3KTJwf4P3Ewx.U
 i1V8v2CAbWwbvH3oj6nA4YgZGuK__B__lV30vDnlbRSDwjhsMdyQuqPa70qB.ioalTHHzN9DEz8w
 FR3VS3y5egExvpd4CgL2AWekKJdz40cFUpKTM3XMjgTPA3RXfjgNeqZ6O1fsxxyMhR3CjhhR46zq
 0Uf7qNhZNAeyFG03zEK0E37FDzd8KAf_rZVJIn.4gw.89jaGwLZfYeZTEVYbHiMTeMQBjMbuzBPT
 zypOTL29MBcbdDwb2_RlwERpMzY3HKP5RUgnD9cXWr9544DsFs4HWYNfKwl9XV2232xkWiN8WMj2
 gpgW0nNSk0jchj00pJo6v4pHhmJHzFKRUoizH.zDZWrDFES1HL0niBhnG.g3Hq8KiEMTPWCKtvOy
 T1LHZ6yVTx0hwv7ovu03Fqe0LIpxhTToBsahk9cJz971tGJor59FKUwlfoG9chwc5xeG.KrCvglT
 jHqHkSk9dJ_7ofag5xfVU74Jlmie06sea0UCN9GI8jQzCTCudBp2q9KXV7g3OB1Rf_gw_8_trnxY
 aVWY3bQqyicZ0Us_8YmQ9lgvHZR_ElFyxMNGaEINJ8FKQCHVHU0lm0Ey1T5GFTW38xnRBonFo17R
 eFGnL_u51o_fgWtKLBVk-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b1d92f14-2d7c-4784-b5b9-4c2920e16dc3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 11 Mar 2024 20:47:23 +0000
Received: by hermes--production-gq1-5c57879fdf-qprqq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e979ddbf4eb120d89b6003a87edbfd3;
          Mon, 11 Mar 2024 20:47:18 +0000 (UTC)
Message-ID: <5f321246-e0ba-4882-a42d-fe174d593aaf@schaufler-ca.com>
Date: Mon, 11 Mar 2024 13:47:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 roberto Sassu <roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <5f321246-e0ba-4882-a42d-fe174d593aaf.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.9.

There are 6 patches. One is a simple refactoring to remove
code duplication. The other five, from Roberto Sassu, correct
the in-memory inode initialization path used by ramfs in Smack.
This is necessary for ramfs to correctly handle directory label
transmutation.

All has been in the next branch and pass all tests.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.9

for you to fetch changes up to 69b6d71052b54fb10feba68564ccb41c0f0ce1e9:

  Smack: use init_task_smack() in smack_cred_transfer() (2024-02-14 10:47:06 -0800)

----------------------------------------------------------------
Smack updates for v6.9.

Improvements to the initialization of in-memory inodes.
A fix in ramfs to propery ensure the initialization of
in-memory inodes.
Removal of duplicated code in smack_cred_transfer().

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: use init_task_smack() in smack_cred_transfer()

Roberto Sassu (5):
      smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
      smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()
      smack: Always determine inode labels in smack_inode_init_security()
      smack: Initialize the in-memory inode in smack_inode_init_security()
      ramfs: Initialize security of in-memory inodes

 fs/ramfs/inode.c           |  32 +++++++++++++-
 security/smack/smack_lsm.c | 102 +++++++++++++++++++++++++--------------------
 2 files changed, 87 insertions(+), 47 deletions(-)


