Return-Path: <linux-kernel+bounces-105451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0587DE07
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAB81C20D52
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D211CA89;
	Sun, 17 Mar 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KV5x1///"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B373A1BC3E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690042; cv=none; b=WQrHYvSbzg7k2zWU2wgQpa3tqoo7lhEgd0OBfJFZVRA4UVmUg5Kpze8S4H+u57Dco6JwUCGjnz5MQAxNL4jdTkSaH+9ex7/gpuOVtmogod7KBw9ttNPwmnhja2pjXbWt12Xiob5fdqbW/vhuiA+53Bnlaf+2CRhmGdhtVZrvR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690042; c=relaxed/simple;
	bh=vo2e5vUn+vFpBQO7O1M3l2GgrAAYge5VyYiA5N9oPBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYQPRgGelFE60K04fwcJd0wmE0ALygWQy0OJouHQoz/ueAP5QC2QQdcPWEZNqoPwHW+Q4fp06DoStQelBeeUqmW1xwjqskoBKBjOF8I+tsjtrKXS409UlSsbbkvRn8jMpw7Zg6roq+4+ncOQXJqHb0TZbJ2SdnhN7dKbtOj629Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KV5x1///; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6da202aa138so1797634b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710690040; x=1711294840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN5rfpbSOuj0X70e90AskrGd/D348RRJczaiDg2murw=;
        b=KV5x1///MCospXRHiHDoaiHklkfuahEJ3kobn8ANIuATZuhhCduawk5BFP0nDMgKyQ
         IttRZ39D9BOJTOjBLw1JiaKIPRzK7QfN5D5NMEclyLaWHM+0rc03MczsC4/C1uHA5IrR
         UzvaGiNe3n9UV2ITcqkNDH09ljtE77eaSG2CwfHF9NwKpXnSm0eiFlEHjHM4pRvgCLz6
         O0gULcZstJLyKtMpmVLrgJoZ3lL1bVKL5EefY3l+JEX78bOVfFR2hB7k+lqDaTX1d0lF
         gN6vYZy+L2G5bPgioiXvEc1O4pCVaaJle9nocwl/AkSVX+8Dak5mLZBFx8zbpKcN4wW8
         amoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710690040; x=1711294840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN5rfpbSOuj0X70e90AskrGd/D348RRJczaiDg2murw=;
        b=VUB9YIEcGVT7nv20OiXIUKadb71hjKt7Mz+PJNJkU49h2MiICxJaCcAnSIOX6AFFlQ
         4nU4bpj1kwJ+36EvPIaGXfjVyjfQZvNTiwcUNyAKj+ysN47ACXipLGYfhlnHCS0oUsLM
         8elO2l5kbvBn3FC5acDrYsdso/JWc1YYFdt2dC1ouR4GBv5Dcx60i3l7qJvBU7uU0QiZ
         kV6NVU2uUNx4x3Rbf2EaEDo8CNpnnqo/lAGwjvgQ1ogpTzzkqdwXf/OJ3p/f0yoBNpGb
         EkAz5H3jP5NkYBIsY8U0chUt9/wRUIZMakGCy1C1OPSUd73eMfvGRek/1r8FalumaS5F
         INyA==
X-Forwarded-Encrypted: i=1; AJvYcCXOBtL07H5mZDXdNfP3q1z6xXsno1kMbMERLB0hoNyovbs/pBEpqUNAXj6I3HYg5zEVkOw5FNswO2a8b3M8oZBf0s0HcduSgIbUJMS8
X-Gm-Message-State: AOJu0Yxr9tqk1Mi3paWb9BpbHOyCEEE3r6mzzSa9egBiAx4UTnNeB1TG
	CiTdIOP9WzumvRGZKgAyhjrfJVNTMGqsOtmbhF9rzpEQMiZL6/bjolwcXYcN8/E=
X-Google-Smtp-Source: AGHT+IG7Xk93BgxDOAwncq6Cbr79dZt/KkPrl6SVBbkXEepBnFuLP09OA7aiplz3FMObC/Wmp0dixg==
X-Received: by 2002:a05:6a20:2588:b0:1a3:6725:4406 with SMTP id k8-20020a056a20258800b001a367254406mr383278pzd.14.1710690040021;
        Sun, 17 Mar 2024 08:40:40 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id le15-20020a056a004fcf00b006e71bfa5504sm1203644pfb.119.2024.03.17.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:40:39 -0700 (PDT)
Date: Sun, 17 Mar 2024 08:40:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ice: Remove newlines in NL_SET_ERR_MSG_MOD
Message-ID: <20240317084037.4ae8806e@hermes.local>
In-Reply-To: <20240317152756.1666-2-thorsten.blum@toblux.com>
References: <20240317152756.1666-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Mar 2024 16:27:57 +0100
Thorsten Blum <thorsten.blum@toblux.com> wrote:

> Fixes Coccinelle/coccicheck warnings reported by newline_in_nl_msg.cocci.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>


Acked-by: Stephen Hemminger <stephen@networkplumber.org>

