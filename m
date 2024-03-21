Return-Path: <linux-kernel+bounces-110077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F38859B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6171C2261C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC89084A23;
	Thu, 21 Mar 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XM3VkmE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XmyzlpzY"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333857C6DF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026670; cv=none; b=n+gKO87jd/1OcsTKGRwUttLxL4GtwMGA+1lRqMOpM3NN9TpjXPaVEty6aeS+5ARuScf53H/72+VasAnDvuSSgLe4Olv3Tj0c7rM0m9BxV3p/KLNYy/WDu+3DcZzHdhENC+Xnd8oYvkLFNHG4KxR/0VhVjBMWziTToT84WPZsc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026670; c=relaxed/simple;
	bh=9GWWrSSLXS31DSzydsHUoZZEnrWx+msnEIlV0vTZd5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RbwBEHvWJTkiq8cli3y/Hk9+IV9n1NOE3A5sbQy0mJ+V4EScZEicpJUVSgmgDV8guklGPw8LR4Isi3CKpgcfy3QboMintxsO+i+lWMNnVC5HOmqGKEGTh4zaBfqst5ykXvGPvlf0WcuOEl2djnp15QAA+iWmzCc1HCA+Ja0V3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XM3VkmE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XmyzlpzY; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id ECCDE5C006E;
	Thu, 21 Mar 2024 09:11:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 09:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1711026665; x=1711113065; bh=TgJVd/c7muVzOn3fIP/35
	wUjaktaAsm+YLuMMYxME5A=; b=XM3VkmE0xPZkXDR8H/hwBnQ7IvMN3mAsgVykC
	pvP+1JXicGkSmfJNXqL+WuFp0jZ2iCpFId+5EYasmV4YdE99hl0TcNWcaKNWQzCK
	8YABxhS/IbQlMxNUH8zJ9ErIUmQuOrgBrEJRqgmV27V/tihRGZWrldFvkW9DYgti
	C9FcAUIAaXOeaWoCEnSoTwLcTWgIXou0YKj7el8ANo6yENmgkktLVYoUaHJq0JYW
	1avqMRHQVIlYh3eQZkiCmCnw8Usl/4EDU0QdEKbsClEC6vzeVEpoOzOYN2sMPdo6
	DVkHAzd40t90AT7BbdtdClKZldDIoz8WSHTYnq4y1XUUODv4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1711026665; x=1711113065; bh=TgJVd/c7muVzOn3fIP/35wUjaktaAsm+YLu
	MMYxME5A=; b=XmyzlpzYt6oo32TzeZ0gbxKIQ2OP90vMm4pbk85uUL/VP+5LE85
	iKympIeOTQ+Qyfh1QTpEUOyxlnN0nwN0594OhwP27+W0iHstarQScOMcIaje/U27
	GN8dbTkzcxJPqcEH/3PTpbtnGktl6LzjU5LuqLSMmadQkutyocGa5a7sJXiTMLg2
	qGDljVDO0I8Usy5pOgVUoZk7KW+jDI+neBPKRKNg3cGtSIs5izov7a92kie5Oq0U
	ij5lchGXV8JWkRndp9zp+J9UzSUg/MeHxG/DmeTeJM/uvirGKmPJHcEHhaRAuK8I
	5qvtNFPoaMX3OKFsxzPfws6w+sAbogi2VKQ==
X-ME-Sender: <xms:6TH8Zb9T9FbkPZrtjToxUEGdTKxONbwzQpQk-vdi4dwmguGCilejfw>
    <xme:6TH8ZXteT6dx7-7c-Awkrc14PhAjCLXNG_6k3oR9tOdOJ4YaPQgxGPBmG3jG6phYZ
    xN0VJbGG879QJAPgNs>
X-ME-Received: <xmr:6TH8ZZAUckZI_BnJqQ8vnyS87XC9RmHJh5lcqIRHcpwBrJNfKCESxz6wNzv6U6gJHgZjMY2GEYO7MnJ98L-AqGiP1Ezk7MwPc_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevge
    dvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:6TH8ZXeNr5bQYhe_9S4UGLgcvxtop72FXmdX0UZDGNWuwsv1IFXPKQ>
    <xmx:6TH8ZQPqz7kZnETY7CsUPlfpuqhcYQFBYR1n2rswWo-LhGlWdoiBNw>
    <xmx:6TH8ZZnxb799fosTY4Abe9u_LV0ofH3ZXOpraZxU05LDDdk_lWCUag>
    <xmx:6TH8ZavlYu9MsxQGH6gEabwXfPw8XVBb1NFMeDig0BzvOk5CDSfWjA>
    <xmx:6TH8ZZYUX4LxE4hyMwwLOU5YyzpVTUYVzDbd2HSWFACs17m1rTTOfg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:11:04 -0400 (EDT)
Date: Thu, 21 Mar 2024 22:11:00 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v6.9-rc1
Message-ID: <20240321131100.GA755005@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

After merging the previous PR, we realized that it brings some regressions
to the device attributes in sysfs. We should have had enough tests before
requesting... Let us fix them in this additional PR.


The following changes since commit 4438a810f3962a65d1d7259ee4195853a4d21a00:

  Merge tag 'firewire-updates-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394 (2024-03-16 10:17:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc1

for you to fetch changes up to bfb1ad3c6aab2341ace13222ac0a78e5b4c239c8:

  firewire: core: add memo about the caller of show functions for device attributes (2024-03-21 21:20:18 +0900)

----------------------------------------------------------------
firewire fixes for 6.9-rc1

The previous PR includes some regressions in some device attributes exposed to
sysfs. They are fixed now.

----------------------------------------------------------------
Li Zhijian (1):
      Revert "firewire: Kill unnecessary buf check in device_attribute.show"

Takashi Sakamoto (1):
      firewire: core: add memo about the caller of show functions for device attributes

 drivers/firewire/core-device.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)



Regards

Takashi Sakamoto

