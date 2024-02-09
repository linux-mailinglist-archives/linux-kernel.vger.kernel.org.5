Return-Path: <linux-kernel+bounces-60000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04484FE60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B776D1F22063
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2131B3AC25;
	Fri,  9 Feb 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6cZG1Wh"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A243D0C2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513007; cv=none; b=phdirkvQ0Jy+QvHdU6B8CDCIMKfos+/TeqW4gVGn1mvEc4Ff0k54xcZ6nal6RhXBKgfOyZdyb8FV8ksovSaQPOAi+LY0qMQh8MqD4sS4r5OhSKoVCYaXj+PLX9zkoDFhHblAPbAbx8TWPcCwDXfeq8efRPDEc3E1Uf8ZnwMYJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513007; c=relaxed/simple;
	bh=KstuKPq2QT85GW66iMsndzDPXM2n5zBwQdqmRdE546Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qYj6kHudCAgTE4nv8DeuVkrbKKFTrZC3rBp2vjOHaxY0kM0z+N0R5eER1g3/GhdbZ6v42UxdBGMBOo2GMihk0TWfE71/hHLLwt1Z1dXGIfjPAOtBePAb2YYJHMzHohtU3UxlxlmNfyIuyCIQr/n4Kdzb5+/MQk1/MfOsthJMlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6cZG1Wh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e04e1ac036so1814410b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707513005; x=1708117805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yxtFfNqdOpZECGkWirsTXPLiH0zhA6e05fl9ilXSY8=;
        b=m6cZG1WhmFsvRLkiV26M3sjc3qkLd2+dpauSbP/5e6pt9ah0vUCdUEvGXtRy7rh6QP
         mXGdhfNp4mvMJ7koHUYPi4Rzp7tq7JTApFI7weJJVP29rxuGM07ZTJ9hn2tmlpxI65wm
         npCaeBD84Wn4vDzoMPNh24VOYs1PjrnlF7JnjlY0UX51T3hZ1hsIC76NH/WMkJall+YJ
         au5CGaANRNmkC5AtqBW+gFSuKeOlN1eXi22lCjIUckZEUbOBjjVze73s5DQVobw5ogQ7
         Nzdge0CXnbCOfK8FgNL/qQBImNK9i9PVokk9HyQJg4h5HrkK3H0bkyUQtaAhJ4KKtPVj
         +u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513005; x=1708117805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yxtFfNqdOpZECGkWirsTXPLiH0zhA6e05fl9ilXSY8=;
        b=tK66i0RVA0t7VRjZ0A37/smrTfDIE1Gt330Sof2iIyDMwqXzu4ocpMIFS9Lw1JDSe7
         OhhmJbQ+R4t7jy6rpZF+fn0nC6j0MTlZ1q9cwM+kng1QhObCYvM21TLaaWOHvyaCgUZz
         rGgdwrUO7F7MIS/NdQrehR9AVEVTHdE6VnTFdsUdC5wwa+1BjNGHOSA78Se2dUlyjtSc
         KkCMMyRYObM0AZSOlojBeLWq3cKO1MoRjhX3SbECrnafX7FlDdvaDO5C65z9669gwFdH
         R5nPD6Su6ls8MJPZbuH9DbHEZKP9fPUQWud40TP+ES2PnUoImdHQLKPsoGestgUB8Clo
         j3Wg==
X-Gm-Message-State: AOJu0YyaKLxNJZ0DWPXxdrEcnfM1QW+u6i8VW1EoDK0gLaBXKJ/B45mq
	RzPePqdinhYYwd/oftPZ6uL5UYprUHAJQVe9xKwlZEWOsBlGMyKB3uTUb7W26+b699Z/aFP7cD/
	znQ==
X-Google-Smtp-Source: AGHT+IHOgP2a7+cFtV5Lwze8UHFIv1ebvvjea4R1e25mn6GRCrxKKHRCDWLSuG+51Jum8I4bEcmP8zW7Pgo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d8c:b0:6df:e3d1:dd0f with SMTP id
 fb12-20020a056a002d8c00b006dfe3d1dd0fmr24307pfb.4.1707513005015; Fri, 09 Feb
 2024 13:10:05 -0800 (PST)
Date: Fri, 9 Feb 2024 13:10:03 -0800
In-Reply-To: <0000000000009c91ce060e87575b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0000000000009c91ce060e87575b@google.com>
Message-ID: <ZcaUq68756CcW74y@google.com>
Subject: Re: [syzbot] [kvm?] KMSAN: uninit-value in em_ret_far
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+579eb95e588b48b4499c@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 09, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=144e8d01e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a65fa9f077ead01
> dashboard link: https://syzkaller.appspot.com/bug?extid=579eb95e588b48b4499c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/589557edbfd5/disk-2cf4f94d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f2480533f00e/vmlinux-2cf4f94d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9463e8eac2ed/bzImage-2cf4f94d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+579eb95e588b48b4499c@syzkaller.appspotmail.com

#syz fix: KVM: x86: Clean up partially uninitialized integer in emulate_pop()

