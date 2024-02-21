Return-Path: <linux-kernel+bounces-75635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E785EC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59521C22430
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246041272B2;
	Wed, 21 Feb 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="SYprxqwU"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED956456
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556924; cv=none; b=MKTKv92gMw4ZgiTqJf/fwFxqDKMk6fPm1qOMk4NqIQ9l0FlKoC5syuJI5KyzIUUp+gkImAgo5mcM5/TQuHX3CDA4RLULYGAtyMjKnVjcL9lTtpXCtfH2wBLgGGpdOu0AyWIiqIo+Jn8MHyg7RFO0fXnlKoH+0zquVwRGRHcgfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556924; c=relaxed/simple;
	bh=ubWxMaDgQA7aCLDJJnk56SO9zudn89gqBTa6kQPbUZI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=fQslLWHoFbXs0VbfdOJoZWwoVvrNS47VWN24+NBRq1uGlUKmjnIINxjboYUa6cYcXIGMZuqb7NTK6jdA8NGlsgl9M3XIbHBZMvghj+7r2DiGSirpxWLCIKzrRAeQ76YiRGzu2PB6q9SVt2fvRaIdSIkhmMZTX98FXc3KQNuSlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=SYprxqwU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29a430c3057so117253a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708556922; x=1709161722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyIdnrPvkMs2AU+vw/nEPIW+QxndqyTNQEwIk71io1o=;
        b=SYprxqwUT6HKzA3P3l8z0BmVIICC5JFM3ziQFzAfWyvPNbcX5r9SJTu0mac4SJgAbY
         oLCFdmHG+FzC6DGV1L1eLHqcVp4tOgJUcCMhtXSkgn6MfCofyiPGxgM/9AEpaMYP5ix6
         zgna/S/AYzPjoKqMomjnRvlGS9HmrKHK6HKm5zoFFIwmG77Ky3ma6z+RAw80R317Q8sZ
         h6JhvRRnuJqFiJZ3+nFrXISXuq3I+ocz3PAlRpOIQKpYOVr/O9ITyPuQejfMZ8aViE8R
         T9S4KcT33FLqR0O/iAuOznF1/Q8aSrPpe+8KYi03MqYqWJ/pu8H6lJ5Vu8kVYEQ8z3FW
         +mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556922; x=1709161722;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyIdnrPvkMs2AU+vw/nEPIW+QxndqyTNQEwIk71io1o=;
        b=WDfXeYhEcdaYjzl01LaGMHmbHzUia7rHzwNbIlMeiYYIo7mfTvBVTxV7d1+rnZvODL
         row4i+9BdIy64g90FZnoJY8AupkUQfm8ojuh6BuYRMUhg6m4kBnyCtOnHKuetXaMgTQG
         2lYHN0lZJFW12MFDQUa1/sxNOlRkoDmd3v0aYKLUEPKh29uWXvVdKcWyd0/LViUjfrxX
         hZ1F9dSiL2PQeVxmbH1Fv6c8gERGhjKndpuw5lajN0Lym6AXM9khSaIdQzuOHM7ak8Bi
         /PccODisZe+YCAOwloYM3DHvJokBsfV7r2EIpTFBYFw1DG0F3R6c+kKXJR6dWVUW3ADu
         4sjg==
X-Forwarded-Encrypted: i=1; AJvYcCWAi9PtAOU5/k2+Fzejo425B24/r0RSIgCfGMLbR9RgWq30E9fUYXHNygrJOYdfRm0BRSOMEO/+eG8Q8t3vVeUr+NZJ6a9xYxucEGDe
X-Gm-Message-State: AOJu0YxYtC1Ki9uiGwXedDSqGeSi7FM7BrjwhUhIAcHlP2f5OlMNH7Sg
	VEhpqkuY7rowUnWsChdJqcZzz+Qjd1K2l2MSEcBDndJTHUuLNe4UnWJuv+na3H8=
X-Google-Smtp-Source: AGHT+IHThDor4vbSwCGzgqxbkS1L4FAjcJEeNqRKW6q1pX8qIRUqKbsUqTEftPikKBnSg4ZOCItd1Q==
X-Received: by 2002:a17:90a:604e:b0:299:3f2a:4309 with SMTP id h14-20020a17090a604e00b002993f2a4309mr12544246pjm.18.1708556921732;
        Wed, 21 Feb 2024 15:08:41 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id qj15-20020a17090b28cf00b002961a383303sm2420580pjb.14.2024.02.21.15.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:08:40 -0800 (PST)
Date: Wed, 21 Feb 2024 15:08:40 -0800 (PST)
X-Google-Original-Date: Wed, 21 Feb 2024 15:08:39 PST (-0800)
Subject:     Re: linux-next: duplicate patch in the risc-v-fixes tree
In-Reply-To: <20240222093025.5f9d9ad5@canb.auug.org.au>
CC: Paul Walmsley <paul.walmsley@sifive.com>, greg@kroah.com,
  linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-57f0dff8-c22c-4e94-be94-376c833e3b1f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 14:30:25 PST (-0800), Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in the tty.current tree as a different commit
> (but the same patch):
>
>   481860974faa ("tty: hvc: Don't enable the RISC-V SBI console by default")
>
> This is commit
>
>   8b79d4e99407 ("tty: hvc: Don't enable the RISC-V SBI console by default")
>
> in the tty-current tree.

Ah, sorry about that.  I'd been trying to figure out why my tester was 
broken and forgot to check if someone else had picked this up.  Should 
be gone now.

