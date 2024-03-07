Return-Path: <linux-kernel+bounces-95744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA68751FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF7C1C221B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568E112E1DF;
	Thu,  7 Mar 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggwxNMml"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A511DFC6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822172; cv=none; b=s0mgOYTsJHc7zWJcGiJCWVNTWScokKX+pweI4JaDIIYbIqATCYWwfbqZzRcpQUeQDS+98mFcW3RWjo7mQd7l+o+JP8nVTRu5BCQ85U4OD+T5o33lGxWA0QRg+3edXwzjBcty1JwTlQHYT1vkRE0sTX6GC2/GCG4KfQSN1JBsUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822172; c=relaxed/simple;
	bh=x02DuFFFXqezeMPeX7N/K3LTJ7TADryYv7HqzE4nsfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtTL4BT1T7fwS6TukifsvRRVEZYj3haVLhky5WVE06VM0rnbkSEyMxOs3d+ZQFa6RTS8ykWa//C0KtWg755tXfOLkR2KdTfA9vkp4Ua4frazcyvv5uwE4nUOXE17a9xthVEpD3muRao9kjaBPV4ZW7BeZiW+YaAe4Wp94AU1Oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggwxNMml; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so295161cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709822169; x=1710426969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6cjTaPA3JGO0htGi6Pjtb9XftoGgbKI0J0q9NK3+w4=;
        b=ggwxNMmlVtIUpeUHoktMGiJt6NHEuOQM92GBz/UjBrcqAbPZLSV+lcvUX5vsIDLle4
         Rpr4J9fD1HtjBPgMylJbxOHmZQVoHVsQqINPQlNrSvHajj/yos4lsrA/vjnvom048meu
         pG91huk7uC+PjD+3hqOSoGZFxGRDqopuTYDzFLp8alN71qJ9OicVc1eOcD7PfkMtsSm+
         piukZftKQTn6WFx6U4wQU3oqAWLmMpVIWdGhpRsAnF+v3QdgU+AQuO592Wam7FYcwPr+
         US2rwNwN9TBdAmIzmggJ/B5KNS0wJ+yo264fpVdQd8Se4FRf9qMvFMTs/hMGpIQZITQK
         wKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709822169; x=1710426969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6cjTaPA3JGO0htGi6Pjtb9XftoGgbKI0J0q9NK3+w4=;
        b=WBsvJppMiT/kY5ss8Y5X2YvP1h4+LlJJUJLQYHFtgAvkhKiUYaZX4aeGvhX+dcXJmz
         mx++ESFvwTOqLZqiELTFAsJUf/iw9hXcXh+yQb0qBAWJAocY/Ohw9pJWgQ1O+RrsRt0I
         N7EdKRl/lOnSN2lxsHC0iL02ggTO16dUmOR2Y8dsRRTvYCEJXATZUTTCk1UBV+mT1cN2
         74tbY+VWxYKbkiv60iGao1e1Hc474ZqbA9jt1R+d+rjnt2rRVNJgaxgRSIMFYc8oW/7M
         9HRbuyS+th/wHAVwRpZRObSqsgrisOh+JeNwyPa0Wbtk0rCWSV4ir0UIPA44oP5Q+l0+
         xgFA==
X-Forwarded-Encrypted: i=1; AJvYcCUrU7xxSFFLnT0Xds3JI9UyedqNOqM4FQVCLdO8QBAFHu63mLajaw1om8ovZd+Yr9qvUA0O7c3tcpFem8m1YEGbiGZMHBU7XNxm+Pu1
X-Gm-Message-State: AOJu0Yy+v+husz2RP3+0ThZ3LMrnKg0r21pd9yEOLMKOLdWDjKUx1D9P
	mLbWvGOCh9fUf/4OcYZps6osAxX+sNzDdr72o+7HmRzj3o7uK7BJYpg73uU7q2fcmFGYoKjlOtD
	0tCEh3q/ClYNRvb2oLkfQSf3Mws/WsgjCt+Jl
X-Google-Smtp-Source: AGHT+IFTbUYTdln+HN5bHEZragkgBfryVrLW7yxjMefRnXhcn7EKiTuuupTzwNyjjzX/gNPojrKZtcxTSe69tmWWdIE=
X-Received: by 2002:a05:622a:1c8:b0:42f:a3c:2d4e with SMTP id
 t8-20020a05622a01c800b0042f0a3c2d4emr266044qtw.15.1709822168971; Thu, 07 Mar
 2024 06:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307094433.3440431-1-xuxinxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240307094433.3440431-1-xuxinxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 7 Mar 2024 06:35:53 -0800
Message-ID: <CAD=FV=U8wdT_5k-yrLVpmh=q4k18LntqujK7Mw88TdweBXCPgg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add several generic edp panels
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 7, 2024 at 1:44=E2=80=AFAM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> Add support for the following 2 panels:
> 1. BOE NT116WHM-N44
> 2. CMN N116BCA-EA1
>
> Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

The patch looks OK, but please resend with a more unique subject. I
think we've already landed more than one patch with the subject "Add
several generic edp panels". Since this is just two panels, maybe just

drm/panel-edp: Add BOE NT116WHM-N44 and CMN N116BCA-EA1

-Doug

