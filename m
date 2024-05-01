Return-Path: <linux-kernel+bounces-165705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A38B8FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97A31C2116C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB8161304;
	Wed,  1 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hq7yxo+N"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945151607BB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590777; cv=none; b=aH3IwpWSb7dhuiam+eOZyJ41dcRA9vHCi3KnLCyifF20LzRhKsDePtjdwOiHYGLCxS23BnForm9iRsjhpMz5cOAV3Ah9UfZ/utUhPuZfAK0jnPB/m2nYq0AqtLROh3i+4YHxXo8txgZUZSWOLTqLhWr7SRpiee62q315ZUoxe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590777; c=relaxed/simple;
	bh=EwKEuDLSOMKR1jV1lR+1TeGQ2t/97k23NvQ/j0JLcjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTz+GinAzBhyjqRNt39xJXpW4msDz4zk+n8v6hx++B/xH4X9Dt0CT/viEyHKPitH5rFwZfUb9x8b8afrceEqazkXnT63WXe77cMgjlXeFOejVSTbGh218nMGiKNsSam6Rm3X1m5C2qlrjrS4I0QULEcezh2GnaZQnBJ12Xsn7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hq7yxo+N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so36136235ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714590776; x=1715195576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftc3aqw2Fz5Res4OfCV1JsnJI6jUFRSYvKQ/iKjV0XQ=;
        b=Hq7yxo+NaW7Cm+zBacnYar2Szf0QA8VfyMW+IOmQUfLN45/uoanAj2i8NwL8Au4UEa
         utNBUAvm5B6gN+k/8J00l9BLYDh9Xl3vcNIJaTEfpN1HymUNSc5K0ImUjsYXpm3sA7HP
         ed11wZ2ShTkIJEzCAH3pDCA+75X6iuyCS5S7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590776; x=1715195576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftc3aqw2Fz5Res4OfCV1JsnJI6jUFRSYvKQ/iKjV0XQ=;
        b=Lq2ZB0MwaRZeC6xHo/qocIJ4B/0o/P4HC4Gygi9EJPrFY9l3hnfSO/h4nEUu6oAkX4
         AwK1/yysBsfXsaLUXkzXkz4Tr+zlitc3w+Wzjj8MLtZQoy8QJrFWdBHcVYwmcESMr2qj
         KapJn1cGiwHObSHyEcJh6vxhhSBCzl1M5wxjEh9WAGG049+hsbgLuUNI+/FrKXwYs0ei
         Bs1t5bOu0M/NXgF05oA6WJf9u5G9g1MfUpnOVX65prRy0u3sXrCdlFcsiH5r4ws6yIRX
         KAzxLMgoV/FZ0X1VMhLr03LFD6NCGbjn6Ybn/BHicaGL57QofX8srohJSCpQKhZ+q89B
         KxQw==
X-Forwarded-Encrypted: i=1; AJvYcCWtFLco6iS92WK47GmAZJinae/Ld1AJ1xsR4kElYygkKs050zKPmiLIlniH9vrWyUjbAbrAIEpR++sMOEAql2Sp1jr9XWRF5bNMB0KE
X-Gm-Message-State: AOJu0YzE7hYg+gGNUpbr3mxtOxiM2nE2P5hNka6HLjsCJsymjUinUipQ
	PhSSm56Kq0+RlBGEYrNY+jxZnql5POtaxdfDyWzKLDwnTTrHfaOAhS1IOPEm2w==
X-Google-Smtp-Source: AGHT+IEiiv4rwNYFZ12Yp4KZFEplJPkRZSFlARmbW5OqhUN1DFUPbsYrXnx1y8Mx4Z+i9AF52A722A==
X-Received: by 2002:a17:902:f550:b0:1ec:659c:9604 with SMTP id h16-20020a170902f55000b001ec659c9604mr3860603plf.50.1714590775996;
        Wed, 01 May 2024 12:12:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001eab473021fsm10057496plg.168.2024.05.01.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:12:54 -0700 (PDT)
Date: Wed, 1 May 2024 12:12:54 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use struct_size() in
 hci_le_big_create_sync()
Message-ID: <202405011212.4F3C0C1D@keescook>
References: <ZjKFWg0f9uU5jxaI@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjKFWg0f9uU5jxaI@neat>

On Wed, May 01, 2024 at 12:09:30PM -0600, Gustavo A. R. Silva wrote:
> Use struct_size() instead of the open-coded version. Similarly to
> this other patch[1].
> 
> Link: https://lore.kernel.org/linux-hardening/ZiwwPmCvU25YzWek@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

