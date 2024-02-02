Return-Path: <linux-kernel+bounces-50128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FEF84749B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747451C263C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCD1474C3;
	Fri,  2 Feb 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od+17W6/"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B12145B07
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891020; cv=none; b=rAkuDAYYsxfF28WnxF8DD4/zQz0fRdXwrfU43SrhqwbaKTMAWo41Cewta47bqHkV+4Tv7IQCTpqk1upqhCmnWMHNJJ+9dbtOtqUpAYA3qHQCBCfDbeRKih2UAcSk/9deWKUwc9zouieg4SSrM3jxX2/DRfKVLqh0eVbWM0bjoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891020; c=relaxed/simple;
	bh=/JPSf114kEPRJ0v1lXGP2TIUielH27gX1xOOoqaI75s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrJnHW4NXBGrc87wwClEqS1Kw+RQJKrs4NVOYL/3qkgwPb3GV62jOTVjmox4D0hvaaII0QubT/5ZnGfVxOrYQ1JFmJ70rHL5csqV/kuOAenowJtEe0fyXLg2rmRZpfaYFhvHlnXzUjJUgswQh1bj2ZXUrqsSgXTkfwzWqCVeXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od+17W6/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-218dd3fdb7cso1238668fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706891014; x=1707495814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+06YIBVDdULWxw5GQnDnWyMeZFXiBJGy11XybxUBgE=;
        b=Od+17W6/OxUfdcZG1O57TXXYSw5QTqslcW8TInz6w1ifJ1mzPwkp42RHVEN15xHJ9s
         YWkxVdC9yVpFuO8ynkI3RDERBHeSYKysVXb+zJWG8Vh9E0NHf+wzfJZ9utHvJsjHFd7C
         EZTb4xoW/93vMz9tDLncFPmVTFz38HPl/lfoK8bFhlLdOqLFM2efM2StBXfBMQHCcgtR
         G2/Y0+N0zQSDuAQvJ00FoK9SlBs3xkhxAqKkhUD1lbIzmW5FHXBXfbwYUAY8WaZtDBDN
         nQ822DLqe6kVz/UWG++y88x9ZmY+sL2mFAqbNCcSglmhLCHCarGo41VmZvn2JBkkCIh9
         l5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891014; x=1707495814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+06YIBVDdULWxw5GQnDnWyMeZFXiBJGy11XybxUBgE=;
        b=NDm9R2ci+b6fLOpcyxLnTPl0IYljme2uhnmQccLfZ+5FafHTrIXbGitLedyNsXCGZs
         6faMgJpZQViW6K9kUeNaxzkRUHEUqIkR7i/qRpUJEruM3igIBV4o3D43s1GOikgKPlWV
         WXTkSsDgRKJya/X5y5Vn0Odc2sw9Wqjd6EjV3C3ZKc8jc6EY9LalpqWq/5WZVPvQQpW5
         UZpnXj4U/DUHhd7fZ2kxb3DfjhZcGQEseldknsJ35EMlex4RrkjPKhJYK1D2hQKPzJSC
         fkO8wWexiZWS6/eTGCw0mTS6kEhspfUZtW+6U3V/yErqT5JkkhtKHXKxBU2kUZGkWqW4
         DA8A==
X-Gm-Message-State: AOJu0YzlOA/CwvF+siF9sIYkJQC2WUhengtqVLrN8O9slWbZbtJzlYc8
	HVGPc0FA4xsUKtINBTYl0mYng6C405SfVLseSVDAvEDdajAdUWL4cpLrppK9nvccCbkVN7DSijI
	Y4lhB3Sdm+4VjAG5ZLWNUPHX5+oT3PqRW
X-Google-Smtp-Source: AGHT+IGcxhNRveKxhRVkFCGKQAlFC5u0InvpGQqzsMYza8L7+a2msgAi9LHM0ZYkFHKvlpL+u301GU3524ves7Q967s=
X-Received: by 2002:a05:6870:80f:b0:214:fb4e:6184 with SMTP id
 fw15-20020a056870080f00b00214fb4e6184mr177962oab.13.1706891014071; Fri, 02
 Feb 2024 08:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202084726.91920-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240202084726.91920-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Feb 2024 11:23:22 -0500
Message-ID: <CADnq5_PQGSo1jzLZf7fKw5M25k_5=w+t0-y0=RjfLU5xY-m=fg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify the calculation of variables
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 10:13=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c:236:49-51: WARNING !A =
|| A && B is equivalent to !A || B.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8169
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/g=
pu/drm/amd/display/dc/dml2/dml2_utils.c
> index 1068b962d1c1..f15d1dbad6a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> @@ -234,7 +234,7 @@ static bool get_plane_id(struct dml2_context *dml2, c=
onst struct dc_state *state
>                 if (state->streams[i]->stream_id =3D=3D stream_id) {
>                         for (j =3D 0; j < state->stream_status[i].plane_c=
ount; j++) {
>                                 if (state->stream_status[i].plane_states[=
j] =3D=3D plane &&
> -                                       (!is_plane_duplicate || (is_plane=
_duplicate && (j =3D=3D plane_index)))) {
> +                                       (!is_plane_duplicate || (j =3D=3D=
 plane_index))) {
>                                         *plane_id =3D (i << 16) | j;
>                                         return true;
>                                 }
> --
> 2.20.1.7.g153144c
>

