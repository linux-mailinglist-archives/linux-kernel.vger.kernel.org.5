Return-Path: <linux-kernel+bounces-30248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9ED831C36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AD01C22672
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7521020B07;
	Thu, 18 Jan 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="OhucFEw7"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3521E520
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591229; cv=none; b=egaEBNNXqQ8xy0I2UgdIB1iZcTFn7qowSg/Dw9vr/VhMktj+fVT53QbMvpKB1CaQAzSZDe1i+Z3s5btTMPrhZeICzI1H3pfoA75Z5ehdPcfDLyrXUfVhKs7b/udxg5KXB9cT/5p+BBawNtSNPWNctPXz7GHdzep/xbdVyrVzBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591229; c=relaxed/simple;
	bh=hsA7XwRUq9AvHQB7Mual7yHemrt28pgk6YPC2NorF8g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=b2As4xARzCgPdyyeoCU8T2go8oLgL0ZLo+ts2bbnmPahmpFX3AjYEREU0yyaiaN5fHe2X7A0BACVe1B83V8hTf5jOkGNyb0OgK5EYbBkj0+du7RMfTCP2Zm9xO5GM6XCxf4Reti4kTlZ8LLnngAgUOP9iuSSbUX37J5PNxVsiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=OhucFEw7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbb003be79so310258b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1705591227; x=1706196027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hsA7XwRUq9AvHQB7Mual7yHemrt28pgk6YPC2NorF8g=;
        b=OhucFEw7wskq47/aHrbEK3TR/gKxxQ4KKGcu7KjQcCH46MdTZwO/yPE18dRdwOS/yf
         upTBiBogRkd5Z7FiJ2VMaRMjrEIOLsF4FPtEzvw1sL3u+UYzneCmhf8iDYc+J0uBbPGn
         F00Q9TrTYaF6916wiWNwqUv7QzmM5w/+w67/vz/7yEvWEsy7QpqDKozD3kb2geMo1BWH
         8KMS9Oi1YarcRIs3Tk+Q7yLJuZmydsNYYP2gTcphmN6TtrBpTSV3WogdXkoYeib3NYFT
         4ov3jZD8Tai5E5IHBnEusb37YY9PlwVombN6/tneq4uqC9LldIAlbp4eOpGJJ7j1zegq
         VBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591227; x=1706196027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsA7XwRUq9AvHQB7Mual7yHemrt28pgk6YPC2NorF8g=;
        b=RF6qykq2rVuJxihweFxLe6MqEEA0U+I5EmiPjGVu+3kUJE5JwhUe52/1ulWjh2/iAo
         FLwRJ6fCuAdqOY5tyqvhzZrXUJtYkw88LFGTOxjFdgd9ABxmdxMDJZYmfqUJKGw1dEep
         Ky08vu4Ay/ONd1KcOoWcq2gu0/RTGaJDcdsmgvqM0BrmlfOmE0l+uhPdjTwsFqY9X4V9
         6bnID9+KUVm3+ABh9cj2SBYoYDVVT3XxpEEnxeZxae4eD3suMBrJqDAuf0yu37JHULuM
         +qnzbJ37J8lM6RXm9OCd5e6gPu+IQ7K//lf6g+l9VfY7blqIaKTGtYzHn2L1dNVwHcWg
         MHMQ==
X-Gm-Message-State: AOJu0YxN6/PkL9bputO5A3mBkn1TwqJOMOgAE1VoP/UwtmylkgeCW/bo
	hXr1y8A1EQWEhxXxGdLyyBNQOmNwHZWdFpqK5K1ERwdetDqsl1166lybPvui4H/cRvk4FqR9T6Z
	NHfrrDZTuMyvI2LZQezOlIk9BUyaWYfeJ9Ev2kg==
X-Google-Smtp-Source: AGHT+IG3z53/LzcXY+VSC/21PQDP1HbrJ/14KhhZVi1mqZVshxOouo6pp61K60BW2TDiu4+r+zW9+r83DYRItuZmQAY=
X-Received: by 2002:a05:6a21:318c:b0:19a:4d54:67e4 with SMTP id
 za12-20020a056a21318c00b0019a4d5467e4mr1501531pzb.2.1705591227304; Thu, 18
 Jan 2024 07:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116103131.413205-1-naresh.solanki@9elements.com>
 <e3e16af2-7f8d-4776-9726-f6282128a766@gmail.com> <3a39f7a2-d6db-43c6-961c-63ba6c774970@sirena.org.uk>
In-Reply-To: <3a39f7a2-d6db-43c6-961c-63ba6c774970@sirena.org.uk>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 18 Jan 2024 20:50:17 +0530
Message-ID: <CABqG17gRpAcZhAkxfTnubrQ+d2gNvDk0fspQYZji+ujrLd_+TA@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: event: Add netlink command for event mask
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, 18 Jan 2024 at 19:50, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 16, 2024 at 02:46:41PM +0200, Matti Vaittinen wrote:
> > On 1/16/24 12:31, Naresh Solanki wrote:
>
> > > Add netlink command to enable perticular event(s) broadcasting instead
>
> >
> > I think this mechanism for limiting events being forwarded to the listener
> > is worthy. My original idea was to utilize the netlink multicast groups for
> > this so that the regulator core would register multiple multicast groups for
> > this family. User would then listen only the groups he is interested, and
> > multiplexing the messages would be done by netlink/socket code.
>
> > Problem(?) of the approach you propose here is that the event filtering is
> > global for all users. If multicast groups were used, this filtering would be
> > done per listener socket basis. I'm not sure if that would be needed though,
> > but somehow I feel it would be more usable for different user-land
> > appliactions (cost being the increased complexity though).
>
> Thinking about this some more I do think that global filtering like
> the current patch would at least need some sort of permission check,
> otherwise just any random process can disrupt everyone's monitoring.
> Per socket filtering does seem like the way to go.
Agree. Will work on it & after validation will post the CL.
This change can be abandoned for now.

Regards,
Naresh

