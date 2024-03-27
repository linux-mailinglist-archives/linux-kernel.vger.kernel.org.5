Return-Path: <linux-kernel+bounces-120266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4DD88D518
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25C7B22A98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9D22F02;
	Wed, 27 Mar 2024 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="acQVVFBE"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8E225D6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711510835; cv=none; b=gZvQut4WHJxqaADQU7s4vllXDYYaj6hwZ5/NSQIAJNBfqAHtOH71KdeHHJgqavkSV2RvbVImaAs0AdkUsudbm/yH7SAs50xfZ24nHrDBNa5tCW545nL7+7BnMGZNaMzJo+ojzmAsMncjU8X00yp19zdTU84EWU6Tb4dzXqqYRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711510835; c=relaxed/simple;
	bh=xd68Irl7FMjiKDIsBgFShbHmbskF4+/kOHVxexB+nws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/ShWgeEIPQVnAkpclVzd5uyg5oZ/zbQR5BIh8cf9vgsmsf0p9DHzsP/EslBBv4ngZcEoCZloHYYuLYXI4rYIzw3AtsbanPoE8nTbHuJOsWpbaV0YX7cQwic7G3Vn12PkdagfceB3MxMIDV+e9bbrnE5PUSSP8VE01Ma/whAPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=acQVVFBE; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47651248841so2380902137.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711510833; x=1712115633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd68Irl7FMjiKDIsBgFShbHmbskF4+/kOHVxexB+nws=;
        b=acQVVFBEWn0RSwHrj4H12T2aWbOtW+7zWecBLgI/f2An9AVs9A49kRRoco8PsRWwcL
         oybQQGbPgsoa9UqAMZuNHwgfsFExm56H4CBYQ/PuXuMhmgTkubA6MyD8IEt6Gj9yYP2S
         HfWPngnuutuTH8trcTb8S/sHhQlfsa3pvmEWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711510833; x=1712115633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xd68Irl7FMjiKDIsBgFShbHmbskF4+/kOHVxexB+nws=;
        b=lAjbGFP/o+qakqu1vXLvbgzOYeEyMLHLdTYW3mj+NS90DRwJMLzbl8SRXHP/uRCwOc
         kjwJeChfvQMnEjnrvlgEnbb5R6kTZUoArJy8BhIFvARHQLgHVps6CGOAY2Y668KkyS+v
         E0q3NorRKYFFK/SmGoav3C9WaQQyTEmR9Uj7Sr1sbDWs5f4RBp90wmT4oX3zG6aGFVFo
         CP9/beNnnU3Au3sACwlK4e2+HqkewUBADwQXfyzLtIScLW/Y6ymyTK72FXbqvnMpEgIg
         ZXSQn3boNOY6qD8FTHAaspC9sA19rU89wnXQWgPjMpslr4PQs+5cdvwmT45L7vH3x4dG
         J3iA==
X-Forwarded-Encrypted: i=1; AJvYcCWXwVKQcXQzsc99DWQEH0SLiEkcWFN229qG/ExVbN45af6m8npvyx39Mb/QTkqhaCti8VLJktYXNohzMiG2ak5RxXLIIF2lrsJpPGPR
X-Gm-Message-State: AOJu0YwCG85S/o74PN6PTE+yGKVBSYePiS5zGeUGrrLtVpb/3+Ud674b
	bdiDpjFcOu962GSnBaCTYrvZfkQv/v355fjIX5E9BrrLnFpfyrlJU9qGX/NTQlnFnZECLRp7YyC
	H4XJH6Lm5yyBYksWUKDR020t0V2PoYL6d/TyL
X-Google-Smtp-Source: AGHT+IHGCiSeNt+YDldU30wn4bEUUkwnwRNEFj9Oa4heTmCMtNShSI/XEU8q4wWwhvcP+br+a93tjCv/SBIw00jIxIU=
X-Received: by 2002:a05:6102:510c:b0:476:db9b:c60e with SMTP id
 bm12-20020a056102510c00b00476db9bc60emr3593266vsb.24.1711510832875; Tue, 26
 Mar 2024 20:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
 <20240325-public-ucsi-h-v2-3-a6d716968bb1@chromium.org> <62b2c29f-ca1a-4131-910b-7b9b62a5577e@kernel.org>
In-Reply-To: <62b2c29f-ca1a-4131-910b-7b9b62a5577e@kernel.org>
From: Pavan Holla <pholla@chromium.org>
Date: Tue, 26 Mar 2024 20:39:57 -0700
Message-ID: <CAB2FV=7fqsdDuuxZb4dte+Nm4-Pijk20hGzbT8uvzQKsAfup3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for the review.

On Tue, Mar 26, 2024 at 1:47=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Nothing improved.

Yes. I only added maintainers of drivers/platform/chrome in v2. I am
still investigating why MODULE_ALIAS() is required.

> One patchset per 24h. Allow people to actually review your code.

Thanks for letting me know. I will throttle future patch uploads.

Best regards,
Pavan

