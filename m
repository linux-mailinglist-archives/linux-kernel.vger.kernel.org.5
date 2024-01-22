Return-Path: <linux-kernel+bounces-34252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8581837665
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40740B24362
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916F2110D;
	Mon, 22 Jan 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hKRMANR7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156E10A15
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962915; cv=none; b=SKCpzJzsHdCPrevWjuvDjdA8UL0u7F7DEnuZAyUiSB0ilU4mfuDaU6kxKw3xUW93peqDhsDObV89QII+DNeWYFzkRlbGfo9rHFFSwqzpGPFIMqpM8MD2XTGHwvpXZOO5V5NTVSmN8kecbzVaBzFQ7wuyiL/EsVLfBTblcMWMgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962915; c=relaxed/simple;
	bh=ut2sHK1cYuimB9D9KMgHzTslY/TVKrAQ/ElwwDiRfRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKuHU9poZeaiB1OEdIj54nGw9zQaBTuAA6+3IySvbAxDO2sDXZyc4BZjfAeYDwLKF82gQu0E+AK7gH1Ks+I04GZjHVAaUla1cPGDG8qp5QS2GbXmhgyuEVdwC14tbzNCrgLW62MyOmd+eOwfyfvZpdlabn1i9ap7Kw1154lsjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hKRMANR7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eb2f3935eso4204025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705962911; x=1706567711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAXJjzRSHBzKnL2wNCpgqHq5fkln8HHHx4MUGY+C8nk=;
        b=hKRMANR7qZs/lo5iRScAASeFPSmtx8hcX6XR3X3v96MuhF1bHK69Qb37SfZwifT+PC
         6nNINihMchaGzSlvTJ0puG4pfot4/H50UxEdi7WoWL1OV1GZ4k9ERjx2mHpLsyp9Do3j
         T5MsBTk6jNsuyZV67pgmFzGD55jMKXDaBwZVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705962911; x=1706567711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAXJjzRSHBzKnL2wNCpgqHq5fkln8HHHx4MUGY+C8nk=;
        b=jCx82F2WW30qDK6w7WGf30ivIqgjpsx7m/5cOvFX95aUKBokonVoUjbHHigC1vuXdV
         e17n5JiGEWpHzYLOT9qh+NYtfJkNsMGGhfAsCJ/zK+TPJK5MTqdES0OFEUsWLX1qToAj
         fa8FJznygPH4KZACtjN8kOJDJwscjR0B3zPic6mNbwO0xDUqeBEG1clXgBD6IMXTwlUH
         7r2AVPhWgxbS8s89tFVpAdk4D9LPzMB5Ch1APp7vYNvoq+9BdP8Q34qqC4qIxyswgrrw
         BhBHLprpZcDX4jKQ1nS6quHBD1gFGEY/H35HViDhO4dSxImAiYMa5W2joh1lFlaFHPFr
         QRgg==
X-Gm-Message-State: AOJu0YzK+qc8xmLzcaTJh76wflwyroSFbL3uTzT5JeImhCrv13dGCXvc
	5/DTzMBsP77t12JD09WuNGAzuBfNmF732PavnGDHhrHMpEiWygkHughpHKRRrBGU7fewx4/kkn9
	mOsNY+g==
X-Google-Smtp-Source: AGHT+IHGdND0lAayUGet9h3G4OMxTZcXCSD2348g3xFgW3JI1OQgyotH86OqgxNyJ6WHCDOR5GfvVA==
X-Received: by 2002:a05:600c:548f:b0:40e:4f81:3f68 with SMTP id iv15-20020a05600c548f00b0040e4f813f68mr2475823wmb.16.1705962911443;
        Mon, 22 Jan 2024 14:35:11 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906c00400b00a298adde5a1sm13751813ejz.189.2024.01.22.14.35.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:35:11 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso41037875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:35:10 -0800 (PST)
X-Received: by 2002:a05:600c:4755:b0:40d:609d:d65e with SMTP id
 w21-20020a05600c475500b0040d609dd65emr2785432wmo.177.1705962910573; Mon, 22
 Jan 2024 14:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com>
In-Reply-To: <cover.1705946889.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 14:34:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
Message-ID: <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:34, David Sterba <dsterba@suse.com> wrote:
>
> please pull the following fixes.

Bah. These fixes are garbage. Now my machine doesn't even boot. I'm
bisecting, but it's between

good: e94dfb7a2935 ("btrfs: pass btrfs_io_geometry into btrfs_max_io_len")

bad: f398e70dd69e ("btrfs: tree-checker: fix inline ref size in error messages")

Not ok.

               Linus

