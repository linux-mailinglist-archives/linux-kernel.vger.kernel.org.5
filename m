Return-Path: <linux-kernel+bounces-34277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC3837747
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50949B22D13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7811D683;
	Mon, 22 Jan 2024 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rb+4YSUj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66A29418
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964495; cv=none; b=e3G/ce/DaSdWbZrmdbgLJfku1gCe3tDWvMIzXXBhqJF/wnrdx4hkhY+wPWgREyEY0rvppQcn5QcV4G4WDGJU+a46Hp9r0lE+2uLW77QSThgOtK41b1q+Ds2WwPPpASiE5Elj5Uv2VbltS6SJcgQzko+vOFNzbpmSYU41TUkSvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964495; c=relaxed/simple;
	bh=8cQOxzwWYJnNCmVmBs4ce9ATA/N4mz/+qpEV4kUBcOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWxpjFSiUxqEfCL/ntxSl0OkFsdNqha5P+d5mMDGBDZNa9QhOBL6Mifxkaj5UXVuy0wRfWU2BkjiLejKHecNcabbfgOSqrMaaEuz87HHUQxHpRGfNdEm3/YIDf4mNXXcOEvzSJ+hMCnvzx99OppkhOWQy9b6PFVZHbbog1Qbap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rb+4YSUj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso4071046a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705964492; x=1706569292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TPlzJOHJ8wV3hedKz1a7v4FHImLT+aZ8tnfdq+8evgM=;
        b=Rb+4YSUjWdveoStXtotD3xXwIpIqsuOXpPCqkNYAKiZmRlDv7fZBwMjoPRIBI/d1+N
         Z41fnfedkU4+MU73dgdLoBiHs5+zIuLttQ3k29N1nU1k3jxvVt+1EMnaucXh2YP6Bsp8
         6J6na2OxokLFQc42/wpcHYJ7q/yKSr+x6p2rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964492; x=1706569292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPlzJOHJ8wV3hedKz1a7v4FHImLT+aZ8tnfdq+8evgM=;
        b=cobW2vaX681ixV8//5IJ17XLMpObMj6IGqjw4RpVy+TLr7TpMasflHT3LR8c0uZOax
         CzumOCKC3yxQvKVzCGROfaSEDORNKRJTGXa3R6Mt7E1QT2RzlN4dV9gFxV5vEEnjWAj4
         H8n//d0yPYogb5jWoSRDpiQ28ljaBRkE5Il/CNRtBQV8+kWJjT+cW5lSlNypnlpI9hYX
         6PoFho4i48ZReSJxzJWEaty5wiGHy/pr7i5IYfXxTsq6kCN0hUaDqILwqg1loOIKPixz
         yHuN2+hhVdMtU6IXsAJ5XuCGC3s9kO37CRNQF/M5ywI6lwZreH1ecAjjGcesAlEdgzeu
         fhaA==
X-Gm-Message-State: AOJu0Yz5WRPksIVy7ocWcdshxFCWo3j5sqs6PkP/8RmjAAmHQhjwui+H
	r80/jwWyuspVXTn1E/TQlSI7q6shIV9QCA36NVqP2Zg89ZQibsVMODiLP4XKZ025c1QXgIyIPQB
	PVsY+ZQ==
X-Google-Smtp-Source: AGHT+IGHlCgAHP60yg7M8S1gt5Gd1QSsVwm4L5LjAFsO3JW55x45FWVBNtf+x/tGjKWXlUusCD2IHA==
X-Received: by 2002:a17:906:9c44:b0:a2c:5ed5:7bfb with SMTP id fg4-20020a1709069c4400b00a2c5ed57bfbmr2306012ejc.91.1705964491815;
        Mon, 22 Jan 2024 15:01:31 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id tk4-20020a170907c28400b00a2ce236ed71sm12381063ejc.43.2024.01.22.15.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 15:01:31 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso4165788a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:01:31 -0800 (PST)
X-Received: by 2002:aa7:cfd2:0:b0:55a:9212:33d2 with SMTP id
 r18-20020aa7cfd2000000b0055a921233d2mr364232edy.26.1705964490997; Mon, 22 Jan
 2024 15:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
 <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
In-Reply-To: <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 15:01:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTVe-ZY5jd4tX4=rYEuuUVPECPU3_LvX9qu4nM8pd6_w@mail.gmail.com>
Message-ID: <CAHk-=wjTVe-ZY5jd4tX4=rYEuuUVPECPU3_LvX9qu4nM8pd6_w@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 14:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me reboot to verify that at least my machine boots.

My tree with that commit reverted does indeed boot:

  Revert "btrfs: zstd: fix and simplify the inline extent decompression"

is working ok for me.

I do not think I have anything odd in my Kconfig, and I didn't see any
messages, and there is nothing logged either - just a hang at boot.

                Linus

