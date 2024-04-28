Return-Path: <linux-kernel+bounces-161631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0C8B4ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A91F211E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE80222338;
	Sun, 28 Apr 2024 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmQ5w654"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619961B94D;
	Sun, 28 Apr 2024 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714347848; cv=none; b=fsFRCWDVXGtZkPBUSxSbTsIPt46VbhSJ+OUQSuiXkbJIGZvZmDPPjQ6PtBq5lJHmH2OB2eUWiiWQ4127SZ6ER/gIDLI0hIFMWGpHRhOGzQyC0BlLfU4CDFfzbQlAt9h6fJ5bSnrJrxtxOmkgp19DGeFsyoX3PgVG3CNb6jN0TEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714347848; c=relaxed/simple;
	bh=P4pSsZbJOLiPlwvNaA8UPMudwxP5afpipICNuJRYw3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaAc7UYgILmF/bIHrd+2WNG1FLi+7+qg91MugbSYleSddNZInniDLSl4aTZ2ICcqzP1XYy59ZxYatMSyszNW8+c1JUxOy4X5aT3ArBhhoZyl8V9XBg8VjSytYOUtLuFcPUL/0ItE3306JoK23lV1zp/37xJlbETFLSmmRGyiklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmQ5w654; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so3373391a12.1;
        Sun, 28 Apr 2024 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714347844; x=1714952644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWen3oIWqoShiV/L/ixbpAd1jwRgWyzUqTj1dio342c=;
        b=mmQ5w654bZWPm76Y9SZTKuW+p6e07Q1N2tze5vgKE56OqE5R918jZBtHWInKrOejCE
         EOno5WN7kZy/N89UVDMAHNN8jiy6SPK23Wgdd8ebQgH1jNWerrOKnaKqsYSWVe8C6njz
         PiZjnC8U3Tx2GIj15AR1rCgjaoj1CEFcNxAe4+RkrzM7fST3duqeicPAY9KNKBJN2wQN
         9MWchYgYdiHlf6kNtrOXwMWW9kKRb/chqE7KpArw2wuMP8kdrZxfyNxn2E16+xWU8VV1
         +KQxBvbpl619ooZKjztqV3lUD6hneFX30IqGnUNFSLyUBSMjiZrnzgG56UZwaZ2HhbRr
         ukhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714347844; x=1714952644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWen3oIWqoShiV/L/ixbpAd1jwRgWyzUqTj1dio342c=;
        b=rh3LJsbjF2EJ6hiu/n1ry6450M3EtFs3ZSQTMLEWiw6PB9CO0677O5YGvMnamAtSyh
         QhL0cEJEhwR/A1rTiZu2V6tKvV8Qot+Z2wrSvrKN8R6KO/S7HnpIy2RMe6QR4HXvAq0p
         lZ8uam4BzsLrQbbTMX2LqSWZds2lfFmztoOxLlFLeqjqVyW6XC7vFM/lzcpEGApVFme1
         k/C52FbQwOXYXVWifrTgaQAIg0JnIp6opmS1mFtPVsl39cw5Ho8VhdQz+zmcUiaSSQdL
         eR2BeWOjHTqN1GcGlLpHtAK/Ly9ns3b+3yX2A5Y2otVgZAlm6AVuKs9ZKp/CH1vELfUQ
         yHCg==
X-Forwarded-Encrypted: i=1; AJvYcCVSgxF66vFyix0C54/x1i6A6OS7mf/e9RzByeJA1tAK9cTgugTm0GSBj4unEOsZ2s8qmd+JuOJ/x3kobCjgK5dOI+6H8B6SGemQG15r
X-Gm-Message-State: AOJu0YxawDSSoKB2aAJsIvj5ozSLxFf8zByqQlM6+Z8/NYT68CwJvRA9
	fnl9Vm3lH+SwYLsDKSql6a/sPmoO65+CIqVSdnXmKxJxgHqLCmhoV+OK9Ea76WGQkvL8WRLseoe
	Z1QCMedk611Xv4YXF2StLJ2CS0ZU=
X-Google-Smtp-Source: AGHT+IGfeLGDjslc6YjYtUpJg6sAHgvP0mFSLMeVHEAdUi86j5u2IK75O8bfJkegWpnNDHUhXysd512ptK4JvfICnbM=
X-Received: by 2002:a05:6402:348b:b0:56d:f7ce:e879 with SMTP id
 v11-20020a056402348b00b0056df7cee879mr6769932edc.37.1714347844431; Sun, 28
 Apr 2024 16:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi2vDUZuVAEh4-yS@google.com>
In-Reply-To: <Zi2vDUZuVAEh4-yS@google.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Sun, 28 Apr 2024 19:43:52 -0400
Message-ID: <CAKf6xpv76BO_n2VSAcbRfWowceXjiBSKHjx1nGakXzFHUiS6+Q@mail.gmail.com>
Subject: Re: [PATCH] Input: try trimming too long modalias strings
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Sat, Apr 27, 2024 at 10:06=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> If an input device declares too many capability bits then modalias
> string for such device may become too long and not fit into uevent
> buffer, resulting in failure of sending said uevent. This, in turn,
> may prevent userspace from recognizing existence of such devices.
>
> This is typically not a concern for real hardware devices as they have
> limited number of keys, but happen with synthetic devices such as
> ones created by xen-kbdfront driver, which creates devices as being
> capable of delivering all possible keys, since it doesn't know what
> keys the backend may produce.
>
> To deal with such devices input core will attempt to trim key data,
> in the hope that the rest of modalias string will fit in the given
> buffer. When trimming key data it will indicate that it is not
> complete by placing "+," sign, resulting in conversions like this:
>
> old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> new: k71,72,73,74,78,7A,7B,7C,+,
>
> This should allow existing udev rules continue to work with existing
> devices, and will also allow writing more complex rules that would
> recognize trimmed modalias and check input device characteristics by
> other means (for example by parsing KEY=3D data in uevent or parsing
> input device sysfs attributes).

I think adding these links may be useful for cross referencing:
[1] https://github.com/systemd/systemd/issues/22944
[2] https://lore.kernel.org/xen-devel/87o8dw52jc.fsf@vps.thesusis.net/T/

> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you for looking at this.  I think this idea of truncating the
modalias is better than just dropping keys.

cat-ing the individual sysfs files works, but there is still an issue:

# sudo udevadm trigger --action=3Dchange
[  601.379977] ------------[ cut here ]------------
[  601.395959] add_uevent_var: buffer size too small
[  601.412009] WARNING: CPU: 0 PID: 630 at lib/kobject_uevent.c:671
add_uevent_var+0x11c/0x130
[  601.440379] Modules linked in: xen_kbdfront xen_blkfront xen_netfront
[  601.462078] CPU: 0 PID: 630 Comm: udevadm Tainted: G        W
   6.8.7+ #2
[  601.486003] Hardware name: Xen HVM domU, BIOS 4.19-unstable 03/09/2024
[  601.504867] RIP: 0010:add_uevent_var+0x11c/0x130
[  601.527988] Code: 5b 41 5c 5d c3 cc cc cc cc 48 c7 c7 c0 3c 4d 9e
e8 49 4c 1c ff 0f 0b b8 f4 ff ff ff eb ce 48 c7 c7 e8 3c 4d 9e e8 34
4c 1c ff <0f> 0b eb e9 e8 eb e0 02 00 66 66 2e 0f 1f 84 00 00 00 00 00
90 90
[  601.590038] RSP: 0018:ffffadc60053bcf0 EFLAGS: 00010282
[  601.612133] RAX: 0000000000000000 RBX: ffff96f943c0a000 RCX: 00000000000=
00000
[  601.634794] RDX: ffff96f9bd428cd0 RSI: ffff96f9bd41d740 RDI: ffff96f9bd4=
1d740
[  601.651867] RBP: ffffadc60053bd50 R08: 00000000ffffdfff R09: 00000000000=
00001
[  601.677718] R10: 00000000ffffdfff R11: ffffffff9e65cc00 R12: 00000000000=
00003
[  601.699194] R13: ffff96f943c0a000 R14: ffffffff9e0db1d0 R15: 00000000000=
00000
[  601.718038] FS:  00007fa9a1084d40(0000) GS:ffff96f9bd400000(0000)
knlGS:0000000000000000
[  601.741494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  601.761050] CR2: 00007fff40d8bd58 CR3: 0000000002712001 CR4: 00000000000=
606f0
[  601.783095] Call Trace:
[  601.791569]  <TASK>
[  601.798207]  ? add_uevent_var+0x11c/0x130
[  601.810481]  ? __warn+0x7c/0x130
[  601.822437]  ? add_uevent_var+0x11c/0x130
[  601.833016]  ? report_bug+0x171/0x1a0
[  601.848035]  ? handle_bug+0x3c/0x80
[  601.858013]  ? exc_invalid_op+0x17/0x70
[  601.873026]  ? asm_exc_invalid_op+0x1a/0x20
[  601.888058]  ? add_uevent_var+0x11c/0x130
[  601.899042]  kobject_uevent_env+0x28e/0x510
[  601.916043]  kobject_synth_uevent+0x326/0x330
[  601.927373]  uevent_store+0x19/0x50
[  601.940381]  kernfs_fop_write_iter+0x122/0x1b0
[  601.952343]  vfs_write+0x299/0x470
[  601.961853]  ksys_write+0x6a/0xf0
[  601.975611]  do_syscall_64+0x52/0x120
[  601.985363]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[  602.001942] RIP: 0033:0x7fa9a18693b4
[  602.058258] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f
1f 80 00 00 00 00 48 8d 05 49 53 0d 00 8b 00 85 c0 75 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89
f5 53
[  602.107044] RSP: 002b:00007ffc204b01e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  602.125072] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007fa9a18=
693b4
[  602.144401] RDX: 0000000000000007 RSI: 00007ffc204b02d0 RDI: 00000000000=
00003
[  602.161037] RBP: 00007ffc204b02d0 R08: 00005641874fbcd0 R09: 00005641875=
78700
[  602.183535] R10: 0000000000000000 R11: 0000000000000246 R12: 00005641874=
fbbf0
[  602.201557] R13: 0000000000000007 R14: 00007fa9a1935760 R15: 00000000000=
00007
[  602.220506]  </TASK>
[  602.227408] ---[ end trace 0000000000000000 ]---
[  602.239544] synth uevent: /devices/virtual/input/input5: failed to
send uevent
[  602.260848] input input5: uevent: failed to send synthetic uevent: -12

Another path needs to truncate the buffer?  Or the problem is that the
total uevent buffer size is what matters - not just the keys modalias?

My other thought is wondering whether the presence of '+' will cause
parsing errors?  Has '+' been used before - or will it be an
unexpected character?

Thanks,
Jason

