Return-Path: <linux-kernel+bounces-60015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8129684FE8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A1328694B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C317BD3;
	Fri,  9 Feb 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV6aGV91"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6816439
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513141; cv=none; b=EUf8kiuO1DbH7nQbF/M/rVtajKn3Ns4W5O2tTv0EkzgJuib5kE1M1Ft/sdbvEgBDTW/Jn6FDFQ6bjkhViltrHYYEn84n/DpcN3kjdUXn4uQUfzL4vbf1u3dvsX3oTSADdcWpTm0yCQwmrI5HOM+2als6slNYNvd1YilbqYvCM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513141; c=relaxed/simple;
	bh=Y3+Ins1oBKgC975O26wtVkT7G0S29GC2xhgljws6S2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2G/52bc9+0843pPACcHEo24XxHf/33bQVwOLvTRFdGlr7a5Tl748o+npB6ITbq7w2gxtINkjmtNjuLGeDuEllhp+o9yk3YkH/ud+Y4+ylxb85JgYzNM1t821hBs/0JPgLnHEOp4gbBNaRqQjY2xwDqxnTS0ZqKIS34v2uahIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV6aGV91; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b276979aso910219a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707513139; x=1708117939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3mB95QrY1RqqOrgyZgsOvq1x9jTz+gjfvdIgL/YwvY=;
        b=ZV6aGV91/WFeUtNy3aQlFiQr2071HNkPwZ71YYSgjxUcCt/wix4qJ5y6OtrK2m4PVb
         K6c8G/Aigl5I5NeGIUStcLF3jRwXTwBFqGVQde93pLIGTZLH122O/TrM8scwSVyTHiqj
         8LRzGSBvCaibCAQTsuAGcxKoO/pt/Ebz6vbewLr+OZFbww7di1j6uFS/C0+g1LG2YkYg
         OsKtw/0mu0FzmaPafEaKEjlXLs0iZ+qqp3RhupsO8K5kzF4SwUxVrbK7ikSoISAz2ycS
         NHPFGyXIhADe9fKS1bCB3tXv69N48uPx0R9nyyVv0UYQgy59sHWX67qM0wOA0kfULnod
         XQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513139; x=1708117939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3mB95QrY1RqqOrgyZgsOvq1x9jTz+gjfvdIgL/YwvY=;
        b=ecVM86mNb1OD+Oto3e6mnGRa5acFDYRjefc8U88RFvazrwcKqBd7v26qEKhwAsKQ5o
         oRdudzd8fm+sarCEFgZzL6Xzl4qcBjBOTSV5iCrTaWAzoOL89bUxWD7xUeC8iBrien5c
         gjF0sfeucPo1UMaFntj09Bs9kdAjEIssc/SYKwO66fepQ74qw5KaIOdShERP7jUldFVL
         SoeyvJ1HBbQ/hb62tdFVNfDjKgHGz5qsuhEP+Ry+PdIBbKHPXBrYEAHcJblniZzTnGmi
         Jd9BQnU3UIxfFQgseVR5X93SQCa8V51HNIrbm+snCkyjZEP7J/bwugUW6iW1PyHhUatF
         FGSA==
X-Gm-Message-State: AOJu0Yy9SYbu1v7Ga78Ee2j8zQjVNKdXyIn63GSDgmlqrIShG+QKEFfk
	EsMu8TB2jxkV3ahg9QIJu/r9nYIIjs14mfHNG/Xv1mSWqyqzpI3i53LVt/Z32Ng=
X-Google-Smtp-Source: AGHT+IHDX9FU5rY3+Qp+bjbtjH23R8zd+GTzkcRF/TEt+JD9XAvfHI9istX3gPBKTgABQU/a8XoRGw==
X-Received: by 2002:a17:90a:ea85:b0:295:d223:ad11 with SMTP id h5-20020a17090aea8500b00295d223ad11mr211327pjz.36.1707513139159;
        Fri, 09 Feb 2024 13:12:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtBMLvx1cx9eQ1fc41PrPAq6hPoktshrwATbJm9MCJb3VvYrPRNzF3Ad8y5iYci0Lx/FmdAzoKm4VKfD9+7Ml14gMpo7gfAZE4bTWxmZ7k0wYXDaIKnduzqrfvBKE9ZUhghLevT08CdshtofK5JvKK0rF/V/wk
Received: from localhost ([2620:10d:c090:400::4:62d6])
        by smtp.gmail.com with ESMTPSA id nr5-20020a17090b240500b0029713bbf20asm400356pjb.9.2024.02.09.13.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:12:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 9 Feb 2024 11:12:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 2/2 wq/for-6.9] async: Use a dedicated unbound workqueue
 with raised min_active
Message-ID: <ZcaVMRl2IK8vMpVh@slm.duckdns.org>
References: <ZcVtzJvJCRV5OLM-@slm.duckdns.org>
 <ZcVuWLKN8OHRQuRx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcVuWLKN8OHRQuRx@slm.duckdns.org>

On Thu, Feb 08, 2024 at 02:14:16PM -1000, Tejun Heo wrote:
> Async can schedule a number of interdependent work items. However, since
> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for
> unbound workqueues"), unbound workqueues have separate min_active which sets
> the number of interdependent work items that can be handled. This default
> value is 8 which isn't sufficient for async and can lead to stalls during
> resume from suspend in some cases.
> 
> Let's use a dedicated unbound workqueue with raised min_active.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Link: http://lkml.kernel.org/r/708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>

Applying to wq/for-6.9. Rafael, if you have any objections, please holler.

Thanks.

-- 
tejun

