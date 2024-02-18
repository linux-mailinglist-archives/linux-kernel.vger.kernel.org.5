Return-Path: <linux-kernel+bounces-70394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A344859706
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE37B2115F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE3E6BB5D;
	Sun, 18 Feb 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JhVbExaK"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143A4EB41
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708261319; cv=none; b=EG+Q52nx+fvLvfs6AauUBb5hVMvXcaMUcsdNIzzWOpwqC9tBI/7k2rj//Nxc0Iw59XMh+sM8FZgk1jbDB1Xv1ziTEu841LbnVgng3pkuC+qAVaBprra35CQAm6E2Dq9MuBWpycn4XJYRvu+zwUd9Z829jkrfth0X9IDcuK6xirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708261319; c=relaxed/simple;
	bh=CArwFe0qu0rUAkzUEv7P8qSaBIOWCLLpZlpvdXeYt0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kpgt4itUl8O82QZf2xzMpUiJJcnJwVbb/ohkYM/VrS8MPuW0s5BbNT+VtUoHPcJEvF6jOhWUNUzu3OEB7IkUSmQUVyOUZ3WOWyWBE9jeVBxZ8D2zNcFKyrBKG4caBR7PmXG2vAWUs2b8Cxg7rd4uV6qf+0j/e1mFjFtp2Z4NOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JhVbExaK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2866b15b013so994141a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708261317; x=1708866117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIYyy/W1tr/0bAEhThJxXh8k4ZWLMBlLPwt2pJ+jp6Y=;
        b=JhVbExaKZAiiOrbb7iq5oKT+m7TBI48oaaFxNzw5jUtVohmspPtBQEtdabTwMWaWXK
         xxhsWqfEuWeab9foLvASxXZxlnsbOuRePBQVlfRdlJsm07Y8v2mbct2j2O/3YO0+M91W
         fAY8AqC6yjSvJ8rUrkXCMMsWTVHdGE3gUCTMdW4M5MQ1NkSZaRZ3oPnbkRYK1scD5fpk
         jSXDckj0opFoK4QV088xAW2wiLTiTrpNnwIZXoV6o5+HTfHf2W7L7bY1C+Bpj2e4kypA
         syWWSNbMYvyvOMXk7vYO6/fyBJbm4agCqTHbtWiR/YdjXbH3WOwTtgz52yU+WdY8Z5xJ
         uKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708261317; x=1708866117;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIYyy/W1tr/0bAEhThJxXh8k4ZWLMBlLPwt2pJ+jp6Y=;
        b=m9VRgVfIx/+FMMRejDhkVAMRPXszr55lkQi/vHQ2CxyudqZfKYR4NMFEDwkk4MY5aE
         NrQwjFxpNPMdT45tkl06TerTanEUgQVinjZhltrmfjcRLTE2vdJipp1/vJ8kf5Cr6zew
         Gj0nl+8Wdw3OkmfreWAnRd+LSnprGuf5EOgL5Xy64PzM5C4mvtDgaAJy/jVkns7TC/g8
         yRINvG+sN5yKEb5gT8ERvWX/8msdwcNLjPmDaYMafkTqYEZZ6uDXco0qzXKIASkzJODc
         zW5ctJ8noINWwMHlpSNjDe8+3B9HSgCreqc9BZaYRX616oGw71Fi2BqmVwO/ZuHIbJWO
         qL3A==
X-Forwarded-Encrypted: i=1; AJvYcCXyc+SMQEdr92J3V0MlM2oUOIW7nGV0ffBG8ZhlAP3GyJ/5edf47iQr51sU2j2jreR6IdT62yhw6LwibPALpn1gObY0KZbZOP6UDrnP
X-Gm-Message-State: AOJu0Yyo99SNgkWxiEheOUS/GDnhtN+o8xgLvGH7zuH+zM9fIkIZOPNN
	A0Vjt1MwxdcbfKat6lRk2FymywVCa2M5zHn+z3SakZH0345Q4k26rsqHqHtWwjo=
X-Google-Smtp-Source: AGHT+IFOVa6oJdPekL8bCPtPXjepHYdheq4ZXbm6St90f/I+EkgW0h8RafEA/oyz36xEGT9oV83dCg==
X-Received: by 2002:a17:902:bb81:b0:1d8:ca3a:9d2a with SMTP id m1-20020a170902bb8100b001d8ca3a9d2amr10414358pls.4.1708261317334;
        Sun, 18 Feb 2024 05:01:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d9a91af8a4sm2685725plb.28.2024.02.18.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 05:01:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Kees Cook <keescook@chromium.org>
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>, 
 Michal Kubecek <mkubecek@suse.cz>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20240218042534.it.206-kees@kernel.org>
References: <20240218042534.it.206-kees@kernel.org>
Subject: Re: [PATCH v4] nbd: null check for nla_nest_start
Message-Id: <170826131614.3482432.1638173744340292313.b4-ty@kernel.dk>
Date: Sun, 18 Feb 2024 06:01:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 17 Feb 2024 20:25:38 -0800, Kees Cook wrote:
> nla_nest_start() may fail and return NULL. Insert a check and set errno
> based on other call sites within the same source code.
> 
> 

Applied, thanks!

[1/1] nbd: null check for nla_nest_start
      commit: 31edf4bbe0ba27fd03ac7d87eb2ee3d2a231af6d

Best regards,
-- 
Jens Axboe




