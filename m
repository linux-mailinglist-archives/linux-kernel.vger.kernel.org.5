Return-Path: <linux-kernel+bounces-146692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E48A696E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A0E281F95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4704C128828;
	Tue, 16 Apr 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEavDq4B"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B50128804;
	Tue, 16 Apr 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265909; cv=none; b=F2kdtnaLcwKryxljReYHOzLUSomZHTY2F5rulNaWIrb+NeHU6CllbczrknhX9pZR1dl6XhlCGlIADt7Ik6SZN9ySnKpQ8jscNeVCQ0YlTZ8TUU6b8mpnoNlSGicgalP3P5GizsbMaDmCayyW9zArnQpyro9jF29+i79ECPZli70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265909; c=relaxed/simple;
	bh=BFl6367NyE6/deSY6Tx1gsis0EVhZp4dBESpEhH7OIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg/amTXK5l+J3aa0QIFMBpPKumMwJ5OkVpuVKylrHtvXP19oZa1HfJnByS7QgNjBbvz2EFEpQOH7Pa/DUWIHjsZY5rHI3YwswLm7Yzv7glzkMyPFm927AJpZGOdZVgrPmkqYN9l9rX34WZzuQ2EYC2K1IMCEDPAk8JkOcF724P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEavDq4B; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-570175e8e6fso3435235a12.3;
        Tue, 16 Apr 2024 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713265906; x=1713870706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5RqFUtxcsDcdbF79TlWq+jdC6PmCQermSazbSgPd6I=;
        b=jEavDq4B8qvkbDZJy2GcdqZ6VYOP3pOEp8lJrc+VvqBLufIkmtMtwJVP4Ib9d6PPt+
         8f5Wfi7ajQyYPfjOqL6JrQHt60Cx0d3cnnVJ4ZsDG5bChpOlc15t5dgvbqkxk+tY9uf+
         2yywEb6rLraCP9f+2OuijnjdRlvlOZxv0Gu1kAElR3i+/1MU66CB/VnICP9+iVmtZoKX
         HshJwNwCHMoZS6hUuj9xVNF+hKt9hhjFXT1LPsLXgUgXoSw6ipzIreAOLVy6+YR+3aPN
         2UKWby+9JiNKrNkrsGD/q/1fGNNwywl3kl52w6Wx0WEVBIFV5Z64uSKDxGKPQimoNSdU
         SHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265906; x=1713870706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5RqFUtxcsDcdbF79TlWq+jdC6PmCQermSazbSgPd6I=;
        b=Lgim15DjnArnxbKziPY0Z1OKB0+AIpwL+4tpFaLTZUTNyjLjgYboxhQU+AVKn3bFh7
         2ULDwTUGfSUCnjJYiH+I7sFaDKDkWnoAjmSlOChQUPgXwCbrCbAHWIqGDWnHcHNulTJM
         wHFC6FKM6GsKn/0kmw8qxjxzGy3phEdMM2zF7nNfj2VULUYrHmcX2lQvU7utAl13oPmM
         fuUN2qRR2CxnEGlZvn4oxmpd7i3QiIIA+B/83GW/mgb5sZ6efiEirVCdg9zBavPSCaGa
         pw7ZXWtbNkq74qmnXHOLbq775vdzeisSunDO4yFB6HOUjjVkF0LIpYGup9MJiBzyxOXw
         +ewA==
X-Forwarded-Encrypted: i=1; AJvYcCUcKOwvNtuUxojeuUoDytONx+0uW2FTYtfYIkgIwwe4qFYmXtV+7SnaR9Fu0Cq/cTRBX805vyH0pzUiwJ5R3fQvH5Qm/0xzNopgQRvN
X-Gm-Message-State: AOJu0YzCVoVI1kC5AYazHrmiqBDlSyy85OePS66lC/8CoHw1G00zWhdP
	ZPoAroBj8OTFH6kPJx26EqE5GWY+Mj8P8PCFfIJ3dF3AAETFJA0fQ4omY+vp59ku+ZJ2ECCnSxL
	KZcL9c+s2Mrlipuj1WiRCzWwazk8=
X-Google-Smtp-Source: AGHT+IH1PsRPyaXxP/K5Ox5QKG71lmTEr1SSzwErbC5T+EwPNkfxjV4mnP6QemY+YNWTendRU0/IMWW+eQMyDy5FlyQ=
X-Received: by 2002:a50:d6db:0:b0:56e:2cbc:db77 with SMTP id
 l27-20020a50d6db000000b0056e2cbcdb77mr8541856edj.33.1713265905965; Tue, 16
 Apr 2024 04:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416034626.317823-1-liujianfeng1994@gmail.com> <20240416034626.317823-2-liujianfeng1994@gmail.com>
In-Reply-To: <20240416034626.317823-2-liujianfeng1994@gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Tue, 16 Apr 2024 19:11:34 +0800
Message-ID: <CAHk0HovT_4UdPhoNSR74WvFi-HZhFfdBqib1OM6q_jXAxTgUgA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add ArmSoM
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	sfr@canb.auug.org.au, weizhao.ouyang@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:46=E2=80=AFAM Jianfeng Liu <liujianfeng1994@gmai=
l.com> wrote:
>
> Add vendor prefix for ArmSoM (https://www.armsom.org)
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>

BR,
Weizhao

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index e4aeeb5fe..e47405535 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -151,6 +151,8 @@ patternProperties:
>      description: ARM Ltd.
>    "^armadeus,.*":
>      description: ARMadeus Systems SARL
> +  "^armsom,.*":
> +    description: ArmSoM Technology Co., Ltd.
>    "^arrow,.*":
>      description: Arrow Electronics
>    "^artesyn,.*":
> --
> 2.34.1
>

