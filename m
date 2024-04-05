Return-Path: <linux-kernel+bounces-132542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FD3899678
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF80EB22D45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C603839D;
	Fri,  5 Apr 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTtLasdR"
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22D36134
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301806; cv=none; b=ZRTFz9wuVDM5sRt5CnTbJN8UP9xY4yFBdujXr0jJ1aQKYQM+isDy1KnsCvYyS6CWCsqQUaRGJf2rSgZgKqstSBdKq2nYq1p9XY6VJLLNXrpexvfAFjO5Fo+wdqprqShLDS0sfUXR6oSTKfRjqnInNOfgHhgtcxLwUZzZtJmSDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301806; c=relaxed/simple;
	bh=nWhmRghyNt6Jg/NyCAzSPWxsJwzKVk2yWrFadbiL3wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMZLRQzOnbrCOMINfRFVZxlBlcQpHDuuMHgXPqLZUiNOvtZmToAaMVnFh/zukWwcmzbzikQ7H7GRw0MwGW95WX0P1GdfwqX0xK0T9MLqhAIdbupt9BXzSYvyu/lhlUw7Fls++hu5FdA/OJvsNyBsLLXZDOgpzAPFZgkZ9Ub9jyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VTtLasdR; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-78a26803f1aso108740985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712301803; x=1712906603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JUMwQHIkq2s6PP2HhBebNLyPm3hSUj+L7rns3+rNZm8=;
        b=VTtLasdR0Oc7wFnBWA1/rxtlI/YO71OnvucNT2Zvbb60eaum2WalbK0eToXQCVIl1/
         fTwlUggpOqqfIIFN7P+MH2NON0LaXEROkUfVdZdmITcrNv0R7pcIEl01CErsFG0HO30G
         WLdOQLJb9gPNbw0C8SBqQeWj/g4iQaMHzMWFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301803; x=1712906603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUMwQHIkq2s6PP2HhBebNLyPm3hSUj+L7rns3+rNZm8=;
        b=dq7xkkFuuk0xpLR5IeBeDYY+sJ9Z8/AhS7HLzBJIvmEZiirbsm8Pzrmtf/BRJBDYBR
         DdYfqhcbNovcb59uWOEvziyG7NXrBjWguN1h7pQ7tRnET8F+vC+hyiFWSb71b5fUwzu9
         H7rbSAVQ9plfNEBWbkswP0g1kxq2CCLZ/SK5/qmGH0RGkWPKRsCY8EHPNB+tvZDQFzot
         014jWhPRlMcz3YXFEcE6yBtQXXaIPoWVcOsLYokTHO9RtAIDAqbbOE60Yur7HT2Cd2cW
         ivf9ixdIJse4roEAv43lmjp+EL76NnKLi0uW455zjgu6bNTPxNp+EzOky+dJz5POgoRj
         /r+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWd/3KzmQxc3A407lymlsFxXE8BtggHkhcNvfPF+tc8Jrm66DWKnsfbg+VbPBoumnDWjY0HQXO6PO/eqSgCGTKm0tqBV3mirxiVOXSq
X-Gm-Message-State: AOJu0YxbACWJsWBP1BqtZsnRZ2HXAC6FDhARv32PNtQvV7vYtC0snUxS
	TVzY0Sm/ko88aSDJ3DzSleTBxZwZei7QOxwb2xxcibjwmMOtZSj27t4VoP86adSaluVotQcp7TE
	XEw0W
X-Google-Smtp-Source: AGHT+IGs/OGBw0DYTQJyqvlmwtSbBBLK4vgqop9A89AavVOMniCh5l7cJaRGn2Xt0ehnGvfwBEjF+g==
X-Received: by 2002:a05:620a:5a4c:b0:78c:2f17:8b0b with SMTP id wx12-20020a05620a5a4c00b0078c2f178b0bmr619204qkn.6.1712301802794;
        Fri, 05 Apr 2024 00:23:22 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id po26-20020a05620a385a00b0078d4aab609bsm264361qkn.23.2024.04.05.00.23.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:23:22 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69938e2b71dso5702196d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:23:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP99aEx1Y3m/a8IS3FEAOeuz7fCmtrBLG1pvxzM10y97coMsVhEEaM55Scs+QiO4flNYKySPs40Qsjh4ngY88/jLeJKyhji7YjNhS+
X-Received: by 2002:ad4:5fcf:0:b0:699:225b:bb7d with SMTP id
 jq15-20020ad45fcf000000b00699225bbb7dmr526982qvb.36.1712301801562; Fri, 05
 Apr 2024 00:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-uvc-fix-relative-ptz-speed-v1-0-c32cdb2a899d@securitylive.com>
In-Reply-To: <20240405-uvc-fix-relative-ptz-speed-v1-0-c32cdb2a899d@securitylive.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 5 Apr 2024 09:23:04 +0200
X-Gmail-Original-Message-ID: <CANiDSCv50XHMA5-DQco2r8EbqvB3X9CyaKzyig4JyfiR=3AnfQ@mail.gmail.com>
Message-ID: <CANiDSCv50XHMA5-DQco2r8EbqvB3X9CyaKzyig4JyfiR=3AnfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
To: johnebgood@securitylive.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linh.tp.vu@gmail.com, soyer@irl.hu
Content-Type: text/plain; charset="UTF-8"

Hi John

On Fri, 5 Apr 2024 at 09:07, John Bauer via B4 Relay
<devnull+johnebgood.securitylive.com@kernel.org> wrote:
>
> Thanks for the help Ricardo, still figuring out this whole workflow.

Thanks for the changes. Can you squash 2/2 on 1/2 ?

I wonder why the patches are sent as PATCH instead of PATCHv2 ... :?
Are you using the last version of b4?

btw, if you want to avoid sending the patches to the list for testing you can do
b4 send --dry-run
and that will print the email instead of sending it.


>
> Signed-off-by: John Bauer <johnebgood@securitylive.com>
> ---
> Changes in v2:
> - Made recommended changes, moved control check to helper function and removed dead code.
> - Link to v1: https://lore.kernel.org/all/20240326-uvc-relative-ptz-speed-fix-v1-1-453fd5ccfd37@securitylive.com/
>
> ---
> John Bauer (2):
>       media: uvcvideo: UVC minimum relative pan/tilt/zoom speed fix.
>       Made recommended changes
>
>  drivers/media/usb/uvc/uvc_ctrl.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240405-uvc-fix-relative-ptz-speed-e671f9a34449
>
> Best regards,
> --
> John Bauer <johnebgood@securitylive.com>
>
>


-- 
Ricardo Ribalda

