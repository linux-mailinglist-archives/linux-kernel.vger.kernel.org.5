Return-Path: <linux-kernel+bounces-30866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D2832546
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53EC1C236CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F59DDAB;
	Fri, 19 Jan 2024 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXgcLfOf"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36339208A4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650533; cv=none; b=n/QCxMGR/6AVO8JPhQphLdg4UTJmccpGMNk/czbebfXEnWDVL495D/lfZE4CUE9KMVL2E+h0sito9KGcH8PlD7oY+yU+YBCJT3WFZQvyK3+e8mxQhJ4miQJmADXY1WIK0L4gkazuoc+BVAg6StDPJKVq6EfFtN7B6Ce43m2VGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650533; c=relaxed/simple;
	bh=437pMwh05AkF7Ma5zrf7H0IpeVqtl0ZFLHqUs70QIko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J86utiogRjRTqATye9g2BugKZoSDacU8KnHxQjtQobDy1jkFXL4bZ6clcw6nLEHoCvL5jT7S+j0jFr3ywDigW1ZGqk66MJXRBD7NV7xBJ/9Jmxp8PU9w+1T+X60lhWCqhVJgOFSLRTcjpoNQUJKC6qSZW1BvVzMZpqbLm1WQEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXgcLfOf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-428405a0205so122251cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705650531; x=1706255331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szrFUm5mWLk1fmanvNXQddD8V+/YNa2IQhkuUqvkeaY=;
        b=cXgcLfOfckJ2/5IWSTFnHIAQ4YxrA5QnxU9Z7QM1cX9/gNnKhUfiMeFFY/EoIIsHeN
         SQSnE1s89wKEcHxnG6w/aVacR7zQ+qZ9uEdXTXNiX8KMwv2xkaRHnlXBs/zrtP9SoA5w
         t6tN/jyXAWiQZuslKyDTWhQjLR1NQzl1m7/A2V1cjFhuC0QTeKjQT+WT8bUb8cPNvdTC
         rWcqKu7CjaKWyLMNV1mDINE5aqpbIy9nb9CQ5WZll5NkxrDBr+7pNtY+A+30XLktVk6z
         YsJjdHq1ApB0d/EndEG4I7EkF8Y6jbLo32Qbef3liRECRmuwZ3nVL7ib8tnc86DA0iVF
         zv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650531; x=1706255331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szrFUm5mWLk1fmanvNXQddD8V+/YNa2IQhkuUqvkeaY=;
        b=s7r1NqusQvCH9oIlutP2JG09rp2yZkvoCXPLPHLWWxIwGMqhTOb3iHIZUt+kYQAoB+
         zlwRgj+Xl5bIdxUc4cjDR2Lf3ej6IZY3gv6p27gdvP6dXJ+obxHCn5uRhWNgYLacBzo8
         KXDTQ4QtcexCDaEWtbCrRwmwQgPmpfehUoH6BqIwnvgYRjnaBz2PJJUeI1cP9oRfGEI1
         xoHSrY23bkoWRR1Ru13YpDzB7Fsk/rYUJEn9KeTfzCo9B3tzCuT+Tml+b3YQUN35PLlA
         b48vzcfjKPsuSxlxEn7SjXFhGOAV5pXMf2lLU7DxoRYhzD+YvoBnZ1QOHrT+gFFpD3Q3
         Ktig==
X-Gm-Message-State: AOJu0Ywjeii64wHWEVRDJKSkePWTqOfVIrkphn1g5IrHix63Rptrbko5
	/thfMfzlVlknt1UyKVz8PJgJ39qBnSRvZRNG7tp/XzS71WdyjNbeyPhE80OcQib4rPjFzKCv3c/
	ahdJ1MAfhLaYFzYVa06eC/89y+1ShDUXJcbhP
X-Google-Smtp-Source: AGHT+IHKnNuhZdSTnx1fM+MjdP5tLVjtVO/zdHuvi0LGAI4iEjeq+iR6ewAk+XMnAGAxgRorcKOsq8q4G3VClE1oC4U=
X-Received: by 2002:a05:622a:5104:b0:429:c9cc:daa5 with SMTP id
 ev4-20020a05622a510400b00429c9ccdaa5mr160861qtb.23.1705650531018; Thu, 18 Jan
 2024 23:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118091146.3101-1-quic_uaggarwa@quicinc.com> <20240119004551.234tvv5w2fhhsqrv@synopsys.com>
In-Reply-To: <20240119004551.234tvv5w2fhhsqrv@synopsys.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Fri, 19 Jan 2024 15:48:24 +0800
Message-ID: <CAKzKK0r8RUqgXy1o5dndU21KuTKtyZ5rn5Fb9sZqTPZqAjT_9A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

>       CPU1:                           CPU2:
>       gadget_unbind_driver            dwc3_suspend_common
>       dw3_gadget_stop                 dwc3_gadget_suspend
>                                       dwc3_disconnect_gadget
>

The typo hasn't been fixed.

dw3_gadget_stop -> dwc3_gadget_stop

Thanks,
Kuen-Han

