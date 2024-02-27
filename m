Return-Path: <linux-kernel+bounces-82766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2F86896B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277461F22B74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F31537FC;
	Tue, 27 Feb 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxQ2axHO"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF853E00
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017046; cv=none; b=Q3H/JQz1PhljtpwWdhhucmlH3vhLTtQLkeJRRzBo8f1q4IsDt6G8SeQcbDO9U7xMufLlJ1XaGe3ZjUCVv8gnQHQzwknW1KfRbr/AAntlQTXKuWKBaeqcV8cc7uS9dzvk6cMmfvqEoZCyB5krf0HOdJPo2RhSTwN2PbiKTs4wlh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017046; c=relaxed/simple;
	bh=CPG65n+GxI/uy0eM/O2KvuN3DhTq+x5b9cRnvJbLDFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohQW9VTLDdnVcJNpc+zkY4fQToJUFuTiq/nq8O4wpbRFAamzmW6HaSJ8C9lzW/3I/0q/1PXOFtNAPWJLdrlFeb5d3UmWB6D7dLEGXdq7tTYfgV5ArkvxSkq8c89OXk9LmNJ+ACxkCg9u4IbKPR4tlciBAUudSo5q/tFfUoei7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZxQ2axHO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512e39226efso5335572e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709017043; x=1709621843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYVZLW/axFzRuDYyrPmP2hajXo30/Cydh9CnWHBpngI=;
        b=ZxQ2axHO8NG3FnItsxegruRxMRzZy+EUVf+HXidsq/+BjMhGTvbzrIl6IbpZz8WkpB
         RzNvWKBWdlgT9p0YWwvZTVURNSCUGwpHfHEvj12KF93F2EoRISOGGItY0H+ZikqAc58N
         badCtj8jWvVAIJ31jlQE9X2miT5UVvr4cPoJsq8qAVbxq1VraUtFB8RemyFZOIZYs1xu
         XLlDYyfIzbZEyRj0hbS2mN93/DjKYbV8aM1AYYPpqPVm3s/s55pYPHt2qqrYiaUlwUTK
         ypVVb8w14nVMLWkblcwaQW5YvvwBqbLHmMvpEadaBT5A/TWM1KF5lAH7isW9XjDjqBQ8
         LUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017043; x=1709621843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYVZLW/axFzRuDYyrPmP2hajXo30/Cydh9CnWHBpngI=;
        b=uyfsl3QrY79DsB1tyIUL7CpS14e8vE8kwkpiVJPDXQfVyh9fxYxBXnaLdDABgO5OqC
         moIVfVoQ7BveM414cBgRWd4pJAYrSIh7iQYcq5t9xtb1AzyMSc/Es59q0kYcahO8U6BN
         RXTuDPg+a2i6fy3vZ2QlZRqhnM/jjMmsfnaWYrfLQPJLiGAXJX4ocS7IhnWg4OI+T4hG
         UejSeNDDGSwcpg+EJebSSJGMGJTfhtAHWmb7UGmrdjNVJn1DmJef4ozgkPOUWwX//UKi
         N3aT3/99Fe34LStnhBE8RXUP4hhDMGMu/tFp8oPjs3na6blKLFqMNXon2HzwlJoeoWzc
         Yjfg==
X-Forwarded-Encrypted: i=1; AJvYcCWGHaOQqfV4NNcvHD1ORPS8525lJDtP+FJdW7o10v/qFW05vLsQQzYzG6XamlhV7goCRPPi2K8f+y+rQJZ9BU2TJbmTWvqbdNMgIYTx
X-Gm-Message-State: AOJu0YwGhJ0ELBpSWBIGa2ZA2cRtCJ9Y730IlV6IlaofBYzgh1PvnCLd
	s7Xi2BC2/mvemcrkR06U3lsnIdTLmJpt5oiQM9GXZmMsY0iJJPWwYLwdXEZBcrycrcCa+XNGsv+
	bO+/81qM4tyb3sMDGdMar9oVGxO03oPpj7QSgeYYmvV8hZng9Xmrb
X-Google-Smtp-Source: AGHT+IF4r+KTMpwjEC8S0vMDfPTig3AUlP4fC1ph9rIWf4P50aRwWGKchYxwX6V4YHAUYeLPfpJ3I+D8/BQPTcdvGRQ=
X-Received: by 2002:ac2:518f:0:b0:512:d713:1de2 with SMTP id
 u15-20020ac2518f000000b00512d7131de2mr5515712lfi.40.1709017042492; Mon, 26
 Feb 2024 22:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
 <2024020637-handpick-pamphlet-bacb@gregkh> <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
 <2024020734-curliness-licking-44c1@gregkh> <CAOSNQF2WKang6DpGoVztybkEbtL=Uhc5J-WLvyfRhT3MGWgiaA@mail.gmail.com>
In-Reply-To: <CAOSNQF2WKang6DpGoVztybkEbtL=Uhc5J-WLvyfRhT3MGWgiaA@mail.gmail.com>
From: Joy Chakraborty <joychakr@google.com>
Date: Tue, 27 Feb 2024 12:27:09 +0530
Message-ID: <CAOSNQF2d27vYTtWwoDY8ALHWo3+eTeBz7e=koNodphVVmeThMQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:33=E2=80=AFPM Joy Chakraborty <joychakr@google.com=
> wrote:
>
> On Wed, Feb 7, 2024 at 3:04=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 06, 2024 at 05:22:15PM +0530, Joy Chakraborty wrote:
> > > > > Userspace will see a false error with nvmem cell reads from
> > > > > nvmem_cell_attr_read() in current code, which should be fixed on
> > > > > returning 0 for success.
> > > >
> > > > So maybe fix this all up to allow the read to return the actual amo=
unt
> > > > read?  That feels more "correct" to me.
> > > >
> > >
> > > If I change the behavior of the nvmem_reg_read_t callback to negative
> > > for error and number of bytes actually read for success then, other
> > > than the core driver I would also have to change all the
> > > nvmem-provider drivers.
> > > Is it okay to do so ?
> >
> > Sure, why not?  That seems like the correct fix to me, right?
>
> Sure, I can do that.
>
> Is it okay to change the if checks on the return code to "if (rc < 0)"
> instead of "if (rc)" as a fix for the immediate issue with how return
> value from rmem is handled which can be applied to older kernels.
> In a separate patch I can change the definition of nvmem_reg_read_t()
> to return ssize_t instead of int and make corresponding changes to
> nvmem-provider drivers.
>
> Does that sound okay ?

Hi Greg,

Sent a patch https://lore.kernel.org/all/20240219113149.2437990-2-joychakr@=
google.com/
to change the return type for read/write callbacks.
Do I mark that with the "Fixes:" tag as well ?
It affects a lot of files so might not be able to easily pick to an
older kernel when needed.

Thanks
Joy

> >
> > thanks,
> >
> > greg k-h
>
> Thanks
> Joy

