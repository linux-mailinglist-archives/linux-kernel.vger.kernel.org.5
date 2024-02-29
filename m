Return-Path: <linux-kernel+bounces-86099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9386BF90
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FED1C2239F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5EA374FF;
	Thu, 29 Feb 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3bnpHmm"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C12EAE5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178465; cv=none; b=VckcY4tv6Etz35jvOpUzJvjeHT4sKR9fEBjsE8YPDb56dzp5wqfxdMeX01jPLSPR9A/gNodtjZb4WMKwg9SdP01A9BOFibSBXU0VAdtyFaJqCpMpT5y7xW3QNL6m3YLUyzkPsmzipv3Fxr8p4An1tnDsn7179uikLAwRZ+LVMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178465; c=relaxed/simple;
	bh=GeGiTVG63Aoz4SuA2gUxS4O52MOgjsfemlEYups5F9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ3SfQk0NwdQmQwf4Zw25F04nV7soEXknIeZecEs9KbAf61JwzbiP/pp2zS3Cj4T+0b29+uZ/5efV2OZIQe7qcOqh5NEtV1StF0dBtuHO0hvksNbDIttxBJN9hKq9m5qWDJUaFt8yVyTm1rrJ6hrdIpDo8zYUTxQQRauRDdG6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a3bnpHmm; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-595aa5b1fe0so306784eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709178463; x=1709783263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7r1KhyQxvJ518JFfEHwtdSkxnn70HF9z0iJ/tgTjB7w=;
        b=a3bnpHmmnnEf75E200YYqq4nvV14Dt18zpOee8Bp7Q4+BpRAx28jpJdTQM3n4MF36e
         AYsCeQfQedV1utrmMjAB/eqeps5xW6lVGNYcuvobu397Y1bR7kI80x8nPMIIP9RHgJAi
         lprRktWJmAwoZ8uJMYyl2hjKCWRCyB6OtjYJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709178463; x=1709783263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r1KhyQxvJ518JFfEHwtdSkxnn70HF9z0iJ/tgTjB7w=;
        b=l6IkFN6fz/gga2REsgypJX6WMQIyEs18GMzOwv9MvD2E5MtbwBfxjgO0g0UQyE+HPo
         wkKDpj7pQcY5tftZ+SNx4uAz6mCNNVXJ3ESixPLldzzLJ2E+tADvjctoGceMnpt0iymv
         7Re8ry4llQ81NZ7TWhIYRQuVBlhowqeI93eRMBlYFNYWBEpGmZhBfEMMH7oNT5zudKPJ
         6v8Gdzp/cpv6ulq0Wpr21WV9/HYpWDWN6R1whW4wB6GhZ3x6nbl4WHN9xmExlDVEUWbQ
         MnHuKNKI7DzgVh54i9NfBd2xuUqOWY9ANeBvnOWEIX1P3t2AetxEcuNcyHyY0Tclbsqz
         qutQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl06u55cfWQjWsU7CMx7j2WlkzsJKJOiXzGE4jN0Y4f5KJuk6ALWSHRaDMVGebiacYR+j8aEAY6CoWCFF5I4rRL5PCLdA1veaqgncW
X-Gm-Message-State: AOJu0YxMmpw5rjf9/XdcN3WF8Oil+m35DEPXGuqIsBoV9kLiouINUJGT
	u5uQwvZ6cDfiMZDwlJXsDuL08dbqMhSNxe3Oe0845FNsCsQhXFYyf4urQeTe3Q==
X-Google-Smtp-Source: AGHT+IFddUjlecz3WLhXM9ZpqsGfIvTj+QwrXJ5rjtaXOnpIQb5UTTGVYVU5lvRDOFupaqGBEm4e/g==
X-Received: by 2002:a05:6358:6588:b0:17b:c9cc:f60b with SMTP id x8-20020a056358658800b0017bc9ccf60bmr1865490rwh.28.1709178462803;
        Wed, 28 Feb 2024 19:47:42 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c1:1ad2:3268:cacd])
        by smtp.gmail.com with ESMTPSA id m1-20020a635801000000b005dc120fa3b2sm200148pgb.18.2024.02.28.19.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 19:47:42 -0800 (PST)
Date: Thu, 29 Feb 2024 12:47:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
Message-ID: <20240229034739.GN11972@google.com>
References: <20240222031801.GG11472@google.com>
 <20240222032559.496127-1-senozhatsky@chromium.org>
 <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
 <20240222051621.GH11472@google.com>
 <20240228045652.GH11972@google.com>
 <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
 <20240229021010.GM11972@google.com>
 <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>

On (24/02/29 12:36), Masahiro Yamada wrote:
> > On (24/02/29 11:03), Masahiro Yamada wrote:
> > > > > > > +++ b/scripts/kconfig/Makefile
[..]
> > > > > > > +       @echo  ''
> > > > > > > +       @echo  'Configuration environment variables:'
> > > > > > > +       @echo  '  KCONFIG_WERROR                 - Turn some Kconfig warnings into error conditions'
> > > > > > > +       @echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfig warn about all unrecognized config symbols'
> > > > > > >
> > > > > > >  # ===========================================================================
> > > > > > >  # object files used by all kconfig flavours
> > > > > > > --
> > > > > > > 2.44.0.rc0.258.g7320e95886-goog
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > Why only two, while Kconfig supports more env variables?
> > > > >
> > > > > Right.  I wanted to add only those that we use (and familiar with) for
> > > > > starters.  I'm not familiar with things like KCONFIG_PROBABILITY, for
> > > > > instance, and not sure how to document it (its Documentation/kbuild/kconfig.rst
> > > > > description is pretty lengthy).
> > > >
> > > > Masahiro, any opinion?
> > >
> > >
> > > I do not need this patch.
> >
> > Do you agree that putting kconfig env knobs into help makes sense
> > in general?  Especially those add valuable sanity checks.
>
> I cannot accept the attitude:

This is entirely wrong interpretation.

>   "I am interested only in these. I do not care about the rest,

It's "I *do NOT know* what the rest do".  I cannot document something
that I have no knowledge of, can I?  So as a reasonable start I added
only those that I'm familiar with (and I have explicitly stated that
in previous emails), and I disagree with the "bad attitude" label.

> This should be all or nothing.
>
> I do not think all the env variables can be summarized
> to fit in help.

So the rational for that was that people run "make help" and find
out about new build targets, for instance, but there is no way for
people to find out about new Kconfig features (and yes, we are talking
"new features" here) that are controlled by env variables.  We need
to do something about it, don't you agree?

