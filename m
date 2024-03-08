Return-Path: <linux-kernel+bounces-97226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF887674E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221CA1C2191C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC761DFFA;
	Fri,  8 Mar 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqDfLKQ/"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D11DDFC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911549; cv=none; b=o8uJ3Tx7XE9EKGQAKDiOn0UhlgDe+kc+VYocP2cENzhJmK5cYTf30+qmwmO7wsW4dTV+JzCgD93WwWOJO49yoQuvYMl6e0xeLN76jlW/Oq2Ui6GAr5bMtfokXhJoNi2d6veFaOfJHv35VflB5YIR7yY072Bk0ae/GlAvSgEty3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911549; c=relaxed/simple;
	bh=TFLZXdU3ies1N74nkimz1dUi49Sig9GXkWQrBIaS9r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q61zvEbDGih0p8s9efSNGvLKGfg9OzfqqQlMJWQgdKbMnfVWlHiFKPJMxphSMyrUUAsfjp+7s6KRtq/OE2tCOJREslnh3SzEppxAsJhoU3Yl8ElOjS+2f4zal56GLsNNpecYSoxqD34li+qA8KdyaBHZ2dYkEpumBAF4kBr6i0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqDfLKQ/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42ef8193ae6so272221cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709911547; x=1710516347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFLZXdU3ies1N74nkimz1dUi49Sig9GXkWQrBIaS9r0=;
        b=FqDfLKQ/fbi6S70lRntmG3wXPNXSvPEHkdf5NFj4Kcsa7KOBkDpL10OS6YEI1Z9ZJK
         3TJvmK2Sy2TQ/9BykghT1jWCo4Y3s0hNlwKD2ivcGUm10XYDQ1Gq+G8pQWv3M9+JfEqi
         H31wWdNBuEo7DRRvc7Q+oaY1QwD+5QAckRE2VwS8Ks0MkJn8r55p5lW/YNJw7BlaScgR
         VOOPVE2A6DwVAjse5IaPV1Bf9bWR44EiWCcXo4CLuCUrcOT+2zPpjDsSktTSBevEm2iy
         ly0Alhu3XUG6L3Ovw1l/V0mUZh5SiQyl0GMJ0+A+ByEiGyyRp90SQIrRrLyBir2Gk49E
         pgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709911547; x=1710516347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFLZXdU3ies1N74nkimz1dUi49Sig9GXkWQrBIaS9r0=;
        b=V0vTj7Xli6qVqokUWRM/POj7doZhy+ZJTnCrVVrlSYL82ASf1HJUNjN4+XzjpS0SLn
         IDVOmYgPrJwJRSaWuTUA30cmToREbsYMjaMs/EPeKF+xpE258NR45jZhZAIi79Fk/tNn
         rvnpA6cTTbA97wsocGXi2feT0MgcKzEyImrx4hY0gKJLpchhtl5h1RakYDYMRoQM2cZH
         Yh9+qzAJMfZK6cOMFSRY8SiUX5KvvnYgSHWfN6EmhDkyc3xAHCOne4rSNGuq9gOYnZFF
         CiUWjIACfQsCrYM7XAgm4qvRbf0sFa1DMU/SdN8aJDasm6SMUV9F23YATzNpKElwwihS
         HbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbnjvKgh2CXJSbjKb/8ck7jOSWd+p2q78hqw9aCy6TOdw2OuxPNlvQTEyzFLc/UVPtpRSeCDjmeqXJnnxMl/r9NZTB1ZP/pTXm/Pw4
X-Gm-Message-State: AOJu0Yy9xXnsoTWHGwO/HBepRfLGzQiYlN5972k+Q33VvDtxiDhWJbq8
	qn+YziNb32a43M/jc91eIaBEufqdl6hKU9VzgLH1Vj0fi/yKNMs7rKYbNE5i6qRPjJ0HRmSBcIN
	eaGh6JhhStu8yIxlcendZwO92SMakLiuHWhqX
X-Google-Smtp-Source: AGHT+IGwvRqhH5/5u0dRebXEE93CUmjojhrEOWLQxodoD5XGA8x68lzCwMdItYYAqK5wHkhfsJazt1RD0edt8txgF60=
X-Received: by 2002:a05:622a:295:b0:42e:b2a8:e239 with SMTP id
 z21-20020a05622a029500b0042eb2a8e239mr627320qtw.21.1709911546958; Fri, 08 Mar
 2024 07:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308004757.1048284-1-xuxinxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240308004757.1048284-1-xuxinxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Fri, 8 Mar 2024 07:25:31 -0800
Message-ID: <CAD=FV=V7t8vYZLunDLBh7xDPLoennBP+7Gi6b1Y_GKnYOW1cMw@mail.gmail.com>
Subject: Re: [V2] drm/panel-edp: Add BOE NT116WHM-N44 and CMN N116BCA-EA1
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 7, 2024 at 4:48=E2=80=AFPM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> Add support for the following 2 panels:
> 1. BOE NT116WHM-N44
> 2. CMN N116BCA-EA1
>
> Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

It's fine this time, but please be careful in the future. I never
actually gave you my "Reviewed-by" tag for v1, I just said "The patch
looks OK" [1]. You should only add/carry someone's "Reviewed-by" tag
if they explicitly give that tag.

I'll also note that the subject of your patch starts with "[V2]". I'd
normally expect it to start with "[PATCH v2]". Maybe something you can
fix about your process for next time?

In any case, I've applied to drm-misc-next.

dcb6c8ee6acc drm/panel-edp: Add BOE NT116WHM-N44 and CMN N116BCA-EA1


[1] https://lore.kernel.org/r/CAD=3DFV=3DU8wdT_5k-yrLVpmh=3Dq4k18LntqujK7Mw=
88TdweBXCPgg@mail.gmail.com

