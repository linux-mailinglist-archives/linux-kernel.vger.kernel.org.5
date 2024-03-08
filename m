Return-Path: <linux-kernel+bounces-96420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131AD875BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E4E1C211EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFB224DD;
	Fri,  8 Mar 2024 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwxRzJv9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E822EFD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860337; cv=none; b=IKIZWLTSVHpqOdLsrGbhkQ3Nht9pUy2gvXqtuDd6QTB+hwqZeQaiOXGRIaAOjVjnRPZItCc7Fd5Bg4cDH7BnxjTdQUfmZt3M7yvT3KyLv3MsYUMCSbZfOiYgHowBvIaItKb8Gb0NQu5R6P03/8rPWkbv1AIDV5Eg9gGcn8cSgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860337; c=relaxed/simple;
	bh=1ry6AQG7FDQURpCv8xY189XkCSFEOUrLObp2q9zDSA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irby/RM44jcQP3QKHEgSm1ZQzYlEjc2mJzbbtTKQNjGEqq9Hxa09UI+9th81HWbEB7l3y+jh4Jcc1m62CjC81XF+4x/VbKwrwLvkOGf4ysGrIEzHRL66VguZXTM0TW0sY00/4IU7fGPGmSaHM3fc7hzZlBdUWRpE9iSe5Bh0xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwxRzJv9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e285a33bdso855397f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 17:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860334; x=1710465134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rYDwFy7vdGfEU3AYQcMyBM3b1/hHXEUCIhC7owEbTA=;
        b=TwxRzJv9j4a3GhJI8YL9fGK+qjvQNqX5CQ1nwOZa6UWsHTp8wsNziDZEi0c0aAPLrm
         ClWnDYOu6H0EDmFcnvoRbIu9gj0d6lt+i5LKelVhEWVrev9loYIP0cnRSpxfC6PM67p8
         n1rsho631eo9qmFXAWn55Ur/TXOsQApVHLsItOdclCeuQXvLSmeve8P+k5WUQrJKLDiX
         DE1zT/t9MIwqkrj0J/BlXlKm/1vvd6KDXshmzuP4Ftw1ZZIwgXGO4WyvTgCO51U0mymb
         k2gryKqQ6fF3tRtiy4eBHKbZj6zzYBRH5gURxPSj+dN91ZnUYA5X8YJ/eDnryl1qhVPp
         LrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860334; x=1710465134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rYDwFy7vdGfEU3AYQcMyBM3b1/hHXEUCIhC7owEbTA=;
        b=lRcd97+WhsNjFIC1SYuS0CN23hm9g+csHnRgWTKpjhDxcgFMv0blQXaK03IainHoHi
         cVX+9upIgY1UysFS0Cv9T6vSUWOxuWE5xn5w2GkUQJj8rwFv/cYNgZeSAeR4v257aAPt
         9F7Qz0//8PrXDSfuDtned3qa80pkqZMq1mnAFosGalGxN1IuSdnKTbJ9xGmaKxqhFOor
         VDBXpdj6b75ew0uIZFuOy5RFB/fcivxOLwj1JZhjyTX2J7mbwRP4SNGjzbhIjULG3t4O
         oP2+2OVt3mDuuHrhMe4eXBhh7DQcZW2ByZ0ebh59y8z6W7De2oNwZ7w/ImeN0//LyR7N
         nRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgpld6WS4QY8mSaXyCl/MoB6aQBvOlMNDppw/ALvg5WoG9+TlgzhlftxjtY5HYdw3N9zXMCU/jQOko6pCDfEvf0QKRNHFzVgbvjt8O
X-Gm-Message-State: AOJu0Ywnj8dwbvH3aq6sIzFMFEhR40jdMWSaS+AzflWWVib/KHk+Jwqk
	2zDbBCeMXR3wdDfdsQiRAXfeZI1i7TzCgstTJ7NDJxMJpAlb/IUH
X-Google-Smtp-Source: AGHT+IGKMlg7G8idiMgtUIW7KsMqQOgjBUReKZbtn1HelBvnmw950hTkhxqpW8un5mj/gRLn/HuyMA==
X-Received: by 2002:adf:f7d2:0:b0:33d:6ede:1149 with SMTP id a18-20020adff7d2000000b0033d6ede1149mr13774269wrq.35.1709860334120;
        Thu, 07 Mar 2024 17:12:14 -0800 (PST)
Received: from localhost (ec2-18-169-47-158.eu-west-2.compute.amazonaws.com. [18.169.47.158])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b0033e767cac6csm298769wrn.115.2024.03.07.17.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 17:12:13 -0800 (PST)
From: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
To: regressions@leemhuis.info
Cc: 1054514@bugs.debian.org,
	airlied@redhat.com,
	carnil@debian.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	timo.lindfors@iki.fi,
	tzimmermann@suse.de,
	virtualization@lists.linux-foundation.org,
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Subject: [PATCH 0/1] drm/qxl: fixes qxl_fence_wait
Date: Fri,  8 Mar 2024 01:08:50 +0000
Message-Id: <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
As initially reported by Timo in the QXL driver will crash given enough
workload:
https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info/
I initially came across this problem when migrating Debian VMs from Bullseye
to Bookworm. This bug will somewhat randomly but consistently happen, even
just by using neovim with plugins or playing a video. This exception would
then cascade and make Xorg crash too.

The error log from dmesg would have `[TTM] Buffer eviction failed` followed
by either a `failed to allocate VRAM BO` or `failed to allocate GEM object`.
And the error log from Xorg would have `qxl(0): error doing QXL_ALLOC`
followed by a backtrace and segmentation fault.

I can confirm the problem still exists in latest kernel versions:
https://gitlab.freedesktop.org/drm/kernel @ c6d6a82d8a9f
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git @ 1870cdc0e8de

When I was investigating this issue I ended up creating a script which
triggers the issue in just a couple of minutes when executed under uxterm.
YMMV according to your system, for example when using urxvt crashes were
not as consistent, likely due to it being more efficient and having less
video memory allocations.
For me this is the fastest way to trigger the bug. Here follows:
```
#!/bin/bash
print_gradient_with_awk() {
    local arg="$1"
    if [[ -n $arg ]]; then
        arg=" ($arg)"
    fi
    awk -v arg="$arg" 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "%s\n", arg;
    }'
}
for i in {1..10000}; do
    print_gradient_with_awk $i
done
```

Timo initially reported:
commit 5f6c871fe919 ("drm/qxl: properly free qxl releases") as working fine
commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") introducing the bug

The bug occurs whenever a timeout is reached in wait_event_timeout.
To fix this issue I updated the code to include a busy wait logic, which
was how the last working version operated. That fixes this bug while still
keeping the code simple (which I suspect was the motivation for the
5a838e5d5825 commit in the first place), as opposed to just reverting to
the last working version at 5f6c871fe919
The choice for the use of HZ as a scaling factor for the loop was that it
is also used by ttm_bo_wait_ctx which is one of the indirect callers of
qxl_fence_wait, with the other being ttm_bo_delayed_delete

To confirm the problem no longer manifests I have:
- executed my own test case pasted above
- executed Timo's test case pasted below
- played a video stream in mplayer for 3h (no audio stream because
  apparently pulseaudio and/or alsa have memory leaks that make the
  system run out of memory)

For quick reference here is Timo's script:
```
#!/bin/bash
chvt 3
for j in $(seq 80); do
    echo "$(date) starting round $j"
    if [ "$(journalctl --boot | grep "failed to allocate VRAM BO")" != "" ]; then
        echo "bug was reproduced after $j tries"
        exit 1
    fi
    for i in $(seq 100); do
        dmesg > /dev/tty3
    done
done
echo "bug could not be reproduced"
exit 0
```

From what I could find online it seems that users that have been affected
by this problem just tend to move from QXL to VirtIO, that is why this bug
has been hidding for over 3 years now.
This issue was initially reported by Timo 4 months ago but the discussion
seems to have stalled.
It would be great if this could be addressed and avoid it falling through
the cracks.

Thank you for your time.


---

Alex Constantino (1):
  drm/qxl: fixes qxl_fence_wait

 drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
-- 
2.39.2


