Return-Path: <linux-kernel+bounces-129695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C2896E91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6031C2618E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9FC14389D;
	Wed,  3 Apr 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X04ryGpK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56371420A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145633; cv=none; b=KjXCbRj+unwOSpoKJQlcln3PPccUkJMV8RgluiFsQIzwtDjpeM4ysEOdwRzZGoEvE5Zf8ZZ3U0XWu55KmnGZ0jsQVVpdRpsdofbPX+jCFyzk4iurtq1pbT3mUxwVQa10dXjqLYLXUpoGaefV5witu6krENSmLp73Wfk8+yDHe/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145633; c=relaxed/simple;
	bh=wImattFDArXelRRV1inZjDuiBQ7HC0VainEipOV2SuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JiI3QOnINm3SPj8eFa5qN00p1DLOwyhx6jqVYeZfWgi8/K9V96jAIr73mBZRR5y0vdp5uK1c+K6IohNYn9QuVdMfRHgRCCiX6uR3YN1T+yujNZv6240mfD3pdazPB6CLgszRIiPfqJHiBFB88TLFCjLBW9P/uYB95oeFZD9xSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X04ryGpK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712145630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wImattFDArXelRRV1inZjDuiBQ7HC0VainEipOV2SuM=;
	b=X04ryGpKJcr1gJ2/Jzl9FLJYOyVV/pQgCLm22uG21LAq47q0huLtbJWgsluTO39w9mtA+F
	8162s0QZ/97czzeB9VaWrczSbFgDpyktImf4f+Ed2lUEicTVLUUxZnl5YXRftcqzB/wyiT
	BAbj9qo6O8a6+cnndIe8ws6nZRw4ZqU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-kgD_K3imOiCq4cP8m3xuHw-1; Wed, 03 Apr 2024 08:00:29 -0400
X-MC-Unique: kgD_K3imOiCq4cP8m3xuHw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d81e030e77so4529681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 05:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712145627; x=1712750427;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wImattFDArXelRRV1inZjDuiBQ7HC0VainEipOV2SuM=;
        b=Y5ippZT5SXehJbW2/lloexgT3qgs/CE3pnjkOux48CpWX/pUbBUURCqRgYJDqDeGls
         tlk9dfy9XsgpuBhdr/60c3PvTssp/Gc/dDsIoyC8tQFIHDp0iEruM6eTbAlEiKtrnDBG
         PY65rkmMtBFp32y8WXq18cOWGPmncHm8DJqJxzfp9sOB78WN5G9Gs7wJDQ15pSczyoK1
         Z1Vq6cs9Om097UvRvJhEBBISyjBkQ4poxAuJiRfyjNxrfXGvdA62BiEYgooic36AKVzF
         RMH5+/cOEJs1yCk4ynHXdViwiT2sfqL7LQpcH5zdY9cM9q4y9E6XVzKyM75m4vOweRWD
         rxuA==
X-Gm-Message-State: AOJu0YwK0NqKRmsguz2xRNDyxToVWYwhSN0nBdhMm70TpRe0rMhj/R8z
	hnsM6JK+oifcNnBihjsJwY7mKKP0CDMLJl0IJHjnjsqiz93/uJUahI6OZtW4HpfUxd7wL+qUPqs
	tgvsDoYwiJwP7KrmXy5+QwLf9951MLaWoSj6WAL0MT2zUOpm7K6VwQaEae89rfpK74maCkQ==
X-Received: by 2002:a2e:93cc:0:b0:2d4:6bef:1850 with SMTP id p12-20020a2e93cc000000b002d46bef1850mr8711910ljh.4.1712145627271;
        Wed, 03 Apr 2024 05:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWigifGio5aMuu7CPibwIw0CqhyNmNUucHxm3Doe0O83aqmhIywrsV+6vQ0PRvvKZhUwXRHw==
X-Received: by 2002:a2e:93cc:0:b0:2d4:6bef:1850 with SMTP id p12-20020a2e93cc000000b002d46bef1850mr8711900ljh.4.1712145626924;
        Wed, 03 Apr 2024 05:00:26 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b004156ca1df95sm7578173wmo.18.2024.04.03.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:00:26 -0700 (PDT)
Message-ID: <314f61ffd216fc1d3f6ee2ffa485b6fb5220546a.camel@redhat.com>
Subject: Re: [PATCH v4 0/2] devres: A couple of cleanups
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Apr 2024 14:00:25 +0200
In-Reply-To: <Zg03a4_h1M-AByt2@smile.fi.intel.com>
References: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
	 <bf586356686053641b52902bf7928db08baa44ea.camel@redhat.com>
	 <Zg03a4_h1M-AByt2@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-03 at 14:03 +0300, Andy Shevchenko wrote:
> On Wed, Apr 03, 2024 at 12:53:22PM +0200, Philipp Stanner wrote:
> > On Wed, 2024-04-03 at 13:46 +0300, Andy Shevchenko wrote:
> > > A couple of ad-hoc cleanups. No functional changes intended.
> >=20
> > But it seems that since v3 my "Reviewed-by"s have disappeared. Is
> > that
> > intentional, should I look through it again?
>=20
> Oops, it's utterly unintentional, sorry. I haven't done any changes.
> It is basically a repetition of v2 (i.e. based on your code).
>=20

Alright, no problem =E2=80=93 feel free to re-apply it

Reviewed-by: Philipp Stanner <pstanner@redhat.com>


