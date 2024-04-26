Return-Path: <linux-kernel+bounces-160645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF08B4089
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2F1C22173
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1021364;
	Fri, 26 Apr 2024 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfLqtMOA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C15208AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161345; cv=none; b=rPw51Kj9MMsptS7b7ehjURl6oSpajxiL/RnGHVsgyyQdCmwoOcOpKz/2VxtHVWhLuFwDfihrzM6+NfK+V3C5oHZ+KXJORGrHvTFcy5KLne5y8230lvJxoD/IET3ZaY4TDdVaXgWTIx038Po0tQwuc9V2+fytlTSaFmfP7Bb+cCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161345; c=relaxed/simple;
	bh=Bh5o0QdcQIobo/H4Wrn5STRyPNZ8pLWIRgzThTjZWXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRbGHjYtBsihj0WNVR44H5VQTw8o+XCNzTx5+Ra37WoN529/30/m9NiE0x4lS1R6GS5M8xUF5VDStBEY9jcrZk2xM88BgO75ut7XJAPTxi8vDKwiu2z/Q8c8rksBcmLVyvz4rV7rTU2VeCfIt/NrdTr7VEeup/vgEyyGODGezSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfLqtMOA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714161343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V3u1azg8RiBR7RNxMnu2p6fl2vMhqNcvKFIRuvtoG54=;
	b=JfLqtMOAIqb4p5uf6q5I1L/9RtCAL+vmYNuTrIJW2++LK0pKGR+5jNQgMTiQzx7hDzciu8
	N+K70A26kUfZBjaUEQoEkSeohmF+JsnStvugnoh6W0e1y3s1yOHU4sFZkflBqrXKqExBH/
	2qYn5M26Sl+CQVks23d6D6oZWBQbobA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-v-vXEfxuOXKYa7bH9xatIA-1; Fri, 26 Apr 2024 15:55:41 -0400
X-MC-Unique: v-vXEfxuOXKYa7bH9xatIA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6a0b09ab450so15772506d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161341; x=1714766141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3u1azg8RiBR7RNxMnu2p6fl2vMhqNcvKFIRuvtoG54=;
        b=ostiwqGbTLeayB9o0HaJgT/ZD16DciaKPKWsIqcR4ucFwcKmZsbutWXX4969/R7zgm
         fTFD2YW5dm0XFZCNjd2S9KONXDyu/6zwtxo0MElcrelAIyEBm50wGMnNrdPx6fdxZGWv
         hnFRFzn7iG5fIT+lOEHhL0IV3111JG7V3Zqntn4itC8G+nEZ6CScFTgECa8pF4tyEiP0
         eaHzlwIJtrsL6BVOrXPQ/0dBhBGQ9yAgIXb8Um1v+zKmGqYl1Mp03EN4oXKJZXBJB7JE
         bDulJHJa4qNHDc0ZCokUgJsObxQf/4To12kweZROIXd6qquPUlUsBKFv4iZUoC4d9Y3O
         FGfg==
X-Forwarded-Encrypted: i=1; AJvYcCUKUrofwPfXpIyo7Xb2jjsquvYSH2Qinku712Z79PoqOPBan9zpz8mLWDLfp2sickEsl2sI9Ihucpdb99REp+avEN2j2iAnaV6wYIH2
X-Gm-Message-State: AOJu0Yy6HRvVtSF+sEwhNjIPt3A0OH8SZSPhOOeHeW0Y0Lj1IXKsodQc
	1EOsD+QSeHQeYD774q65YuoPs0RiWKAE6AtkGzeMtdmft85xeaIHx++FpuPZb+YvmIx3aNRz/2w
	Qa9knCl6gjWevmoExHMJSDY6HFl48mqVnmeyi3ioS3qGehNoRUGuEKTn9P9CeJw==
X-Received: by 2002:ad4:5f45:0:b0:69c:b191:4f29 with SMTP id p5-20020ad45f45000000b0069cb1914f29mr6643391qvg.9.1714161341253;
        Fri, 26 Apr 2024 12:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsTEUnZCwn9PILopxcKLFrJt9zb3VN0/23eZXduDoVAbWUmnL2jQVvEnhp9S23TE9mXYK+fw==
X-Received: by 2002:ad4:5f45:0:b0:69c:b191:4f29 with SMTP id p5-20020ad45f45000000b0069cb1914f29mr6643366qvg.9.1714161340964;
        Fri, 26 Apr 2024 12:55:40 -0700 (PDT)
Received: from fedora.redhat.com ([142.189.203.61])
        by smtp.gmail.com with ESMTPSA id v3-20020ad45343000000b006a0404ce6afsm1882268qvs.140.2024.04.26.12.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:55:40 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexl@redhat.com,
	echanude@redhat.com,
	ikent@redhat.com,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: [RFC v2 0/1] fs/namespace: defer RCU sync for MNT_DETACH umount
Date: Fri, 26 Apr 2024 15:53:47 -0400
Message-ID: <20240426195429.28547-1-lkarpins@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,                                            
                                                   
Attached is v2 of the umount optimization. Please take a look at v1 for
the original introduction to the problem. Al made it clear in the
previous RFC that if a filesystem is shut down by umount(2), that the
shut down needs to be completed before the return from the syscall.
                                                   
The change in this version looks to address that by only deferring the
release on lazy umounts.                           
                                                   
Lucas                                              
                                                   
v2:                                                
- Only defer releasing umount'ed filesystems for lazy umounts
v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/

Lucas Karpinski (1):
  fs/namespace: defer RCU sync for MNT_DETACH umount

 fs/namespace.c | 51 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

-- 
2.44.0


