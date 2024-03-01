Return-Path: <linux-kernel+bounces-89108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C486EA8B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BE1F2425C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15513D997;
	Fri,  1 Mar 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QhBpF2Do"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53263D992
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325955; cv=none; b=hW6Y292arIuf1auAdF41g9Pzic/tksTHKZc1kCN6pv3mbH8NZJvvsu2lUuzV9dKRN2TiGwSk5n5gSoYW0zUSuWXPUOw5/Z+es5T70nW3g+gO8MMa2+63437yvmuPBIFPm9ZDCmrQsn7QvaY43HGoy/Xkna35knUZozU4bvqk1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325955; c=relaxed/simple;
	bh=L1mnju6b2hWfk4qgJMRiUjxIH+2I4aVtoC/+dDgCUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jodL9JXDMJQDPltP4HiYktohyjtCEtsB9cmPvucGo/Ajkh4myNX13zplKQLROUKoWTw4wgbe9jx5OyJhnt4YReLIeP1vAwgp4SSLYBcXl8aXHcoAcehqItvSBQw2t7NXev0CNBm5DCG9nbHFzXEA2hUILWhioXacmKnhPVLwKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QhBpF2Do; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcafff3c50so21985875ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325953; x=1709930753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8hRbWiJCnr6KRmDmcx+k7mhGRkhvPSvpUDzp2pK3kI=;
        b=QhBpF2DoqIVWqzjnKB0Urx6e8xhkcdvuKCkBUK/iB6JzHaQkbWQBfmti6OcntLsj5Q
         22KZO+E6zokXeaSzADTynGBeS9IOp4/7HkOTnwrd43V3lQ9+23vumfpg5oB+VrviwomM
         wFMALhe55PpNIKWFBnCfd+dPiXmIJ2kQgCsIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325953; x=1709930753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8hRbWiJCnr6KRmDmcx+k7mhGRkhvPSvpUDzp2pK3kI=;
        b=GKwxo0TVpN/1uKxcf4TRnMWQrpHEAkKbI7oZ37nta1lm52rGLuaMQKAjDhu9DvbQqy
         9UFUg6R0IctQI9rnHRbWVXHxg75bAkAGViQ0MOq7ndpHKa6x0q63Gyb2C0zOmgspPNWp
         mZjDdtJYAFy61d4fpJ25FKWIzPA2kYcyeOutQgd3JOT25eaSFv6+xAk6HlA/bLdwvMgh
         zjHh/vHZ4tHqaGb+9M7KTarx8w+aE0N77wYwFmXxJXRCKjIPXneLB7hjlPLoZXrb1NCJ
         PlQivp21IuN7fpVqt/z4YJopnZb2RRElbbPxIQAh5F/Fzf3SnJcC3MvL69so7AyGU3We
         8RMg==
X-Forwarded-Encrypted: i=1; AJvYcCWqbOPMbs3n4C6CM+oZUtMn3Dqh9VXiArEC94F6LrLPqiqlAnydCEf/LSqUStKgeFR3xCr+/KeYk0aaAYwZo0odDAQrHT9D7cJ0ZB8R
X-Gm-Message-State: AOJu0Yycuxo3Z/6gns+IQbeca4QyzDB1WCCA/IUhWJYFYEF9cY09JyaE
	8OnlpgRSm7PBRQyd8YJS9EzSZr/phY2LelQ+Bag144cvGcIJdntAEJK2T8e35Q==
X-Google-Smtp-Source: AGHT+IEeHOtGROSfO7InBUOVtUOBB5GkfEa/BvdxAw10MRzeVk4FVzrKuCP1P98bzAscQ3onwNP8kw==
X-Received: by 2002:a17:902:c146:b0:1d4:cd4d:923b with SMTP id 6-20020a170902c14600b001d4cd4d923bmr2488161plj.54.1709325952968;
        Fri, 01 Mar 2024 12:45:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001dca997b3e3sm3892081plf.65.2024.03.01.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:45:52 -0800 (PST)
Date: Fri, 1 Mar 2024 12:45:52 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 3/3] spi: axi-spi-engine: use struct_size() macro
Message-ID: <202403011245.3BDA347@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-3-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-3-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:20PM -0600, David Lechner wrote:
> This makes use of the struct_size() macro to calculate the size of the
> struct axi_spi_engine when allocating it.
> 
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

