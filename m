Return-Path: <linux-kernel+bounces-124323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8D8915A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF8B1F22C51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CD40840;
	Fri, 29 Mar 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsxNbjAV"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864E3DB89
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704029; cv=none; b=HTGWA3PuXP6jHDISqMojrLx/r2oFId2p5WF/iz+dauBCmd6riWfJxvSLDdbnsoQ0+bFvhBvd2phiQlUULXvH+0HmJ0mhs6dLSSrGVlVJH35YOLqcJQkXLYmbEFUpoOvqFQLGrdSoqmgex3x+ISvzcoHZxuJzA/kMZp3YlQmRLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704029; c=relaxed/simple;
	bh=lsKygOzvWLl0FFhuYPC1IU4/YVdmC9lNJ/3CEGGRJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmc7XTFf1CgVXUvHXnLiG6YWSpM0lDx5ZL+zgurywv3+lnNGfeXUmLBnDeuezAYsWTAuEsxzC3zKO9wikAVzfI+W0aKLGSMR0xw/EPdkMI5h9L206h04kEbRZbb1OWwamgqt42RnGISoJPcvYG8vWSIrLsRiMvAod7mJALXRpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QsxNbjAV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29dfad24f36so1399651a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711704027; x=1712308827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsKygOzvWLl0FFhuYPC1IU4/YVdmC9lNJ/3CEGGRJMg=;
        b=QsxNbjAVOmX5tDI30F3e8EeyIYbnPG3B3njZ2pfgTd1zMOl8/twy8KAydUo7ulHWKo
         IdHLxf3j/M/jOEyHRwVm+xXfWyRNj+fn4LG6bEN1ZKvZWejuIWshhA5+LVID71sbZPvG
         aHHT7kBam3SgUfzOVjm+VVkvJg+s5nuNY0Vd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704027; x=1712308827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsKygOzvWLl0FFhuYPC1IU4/YVdmC9lNJ/3CEGGRJMg=;
        b=Jgp+tlVJRuyNhvbiBwHhxBOqnDTT6dOZ9PEB4NfILfDQ9t0d8xAagMK+Ysten37HiA
         jgFm4UkrsAFXktkv6Exnt4mNsnPqOKi+BhTxMFwAnmJm1p5cQ8q+ReLOVjn+J+wM6BVI
         0cK+EoVG+AO+CAX22xnKOLd3lPdNqQmfS6ep0tg5PtNiEvdC5iG7XGSbY63W6TpYKxNn
         TWmqkB2y4KS+lDZUssH/0z1NecAOFhIi49mR16Fp8jsUUz9PrFDj3GhfOZIbIaW00IaN
         +ph0O9MGyl+1rwf0Xk4UOCbn/nQunORQ8EAFgECVn8+joW0Vyc6CS29zz929sugI7jo/
         nYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqiVLOk8dGIrd0ZsbIhQ8duXa3Xb4rpO8SrNRc/0HXiu/nyLAVbAFKwwpodAnST6AnTkX4DvSrgk0PnhZZZWWyESbByR7cJtiLgmAM
X-Gm-Message-State: AOJu0YwWZN46as0o03CYeMzPIEKVAVechPBFXX8sVBRE1X9ijMF57my7
	HHy0ROyP/GXIviiFNU1RWJJvH43mZeZLJ5+TPMhpCNPG4H93MAAWXmIJmdQd6w==
X-Google-Smtp-Source: AGHT+IHQqAtT/9cATJMKv9jBfWQX8IflMXS4FDJOKDbHHGfHQMqg53v5n/NfmlEfqYyL7Ohe0pD7Bw==
X-Received: by 2002:a17:90a:b10c:b0:2a2:151c:6246 with SMTP id z12-20020a17090ab10c00b002a2151c6246mr989149pjq.34.1711704027406;
        Fri, 29 Mar 2024 02:20:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:91ca:ac62:b18d:2b7])
        by smtp.gmail.com with ESMTPSA id gv15-20020a17090b11cf00b002a055d4d2fesm2605024pjb.56.2024.03.29.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:20:27 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:20:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: add limit to recompression
Message-ID: <20240329092022.GE1041856@google.com>
References: <20240329090700.2799449-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090700.2799449-1-senozhatsky@chromium.org>

On (24/03/29 18:06), Sergey Senozhatsky wrote:
> Introduce "max_pages" param to recompression device attribute
> which sets the upper limit on the number of entries (pages) zram
> attempts to recompress.

Scratch this one. I think I want recompression limit to
respect size thresholds, algo priority ranges, etc.

