Return-Path: <linux-kernel+bounces-64954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A125E85451A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D62328D91A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF97125DD;
	Wed, 14 Feb 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKaL8Mji"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160E125C3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902716; cv=none; b=Dur6G/T5IHaeszgUkNmthUOdJIWMcLOPi1maeM19Uwwi74DDh6svAvwGtqcvBu0bX68YqDOzstlQc2VlUJ+T16eDEl88Bnedhp4HxrqMXa5gCDjow8WjL5VXKB7jMrpoJGrnq5zkAhsi+77yYlNy/hSyehcqmU/cDQaRbiSg8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902716; c=relaxed/simple;
	bh=J1nlR7f5+4VweetZBJDt8RvIZycTzFvwTxgEJjmw61c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ+bgCOzkIqeJ6YrW6na/oOR1MTWuljWISaQUKhuSNIcLo4k0RXS60CYxn8dk1iZi/AAem7a+vfRHi6cXUyjvvfrn3XVIRI+4fX65dcrc75r/cMFeqwut6EgoIMlzkdkWqs9/OvawPhhRPrfgPJ1Yj2OQBVf03mkt0qpeEQUdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DKaL8Mji; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c02fd8e970so2704938b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707902713; x=1708507513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1nlR7f5+4VweetZBJDt8RvIZycTzFvwTxgEJjmw61c=;
        b=DKaL8MjirId6dopT4tdbhEpmVqg85oNFEqlg2FDbAT88DxZwDLDYjr8VLsRrW1DLb/
         vMkI3fcAvvnYptw2Vo5AMq8y5nLdZMrQcHUfZZ3OWt0Xa+RRAwlqXx5iKDzDs3s9UdDd
         74S1okVEqVMqyJaEkVgc0URunq7/wqZ3SttuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902713; x=1708507513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1nlR7f5+4VweetZBJDt8RvIZycTzFvwTxgEJjmw61c=;
        b=TAvsdjThGgG4iNgJqIQ77NJZO+erUl2hTdfFWBpbpR4i+mx8teE/x4n0lnyia9kwVY
         HI+YcZos4jC9QGrcrsLYUb6tV31TXcLnzbR1qO7SxDA2MATY2CYFDtOi3ePjqbiiCn8i
         zSxPNka9TgMJzosDbxpJkavkNjJ1785ZijHI4g0POcbY0pPNQuTfDcC99yIA8ScKtVm/
         oBCXP9ALhWrO6+g2sbaRLuYVK4NOU6aypA+lcdiqrnhIlueHWtyecRpte7seDROPzHLq
         EXYuaD964GLuVYdiETsU2H5Tv0SLQ+PDlYlOSw6ehJABXr5NL4mJLjBB1nJ8zXzWzk6p
         kNXw==
X-Forwarded-Encrypted: i=1; AJvYcCWesUlAkuG7rXJ3jzeVTjE9sPXkt7EFxZZz5KSGyjZCSGy3q5CP4PCy/NN0uqJgG58Tk4lo0zifuLC/zCQiCyq9KmSYOqLMvYMopqci
X-Gm-Message-State: AOJu0YzYC/LC6KSWc0b8yLUBQV6X5PnhPqT2iE19fhVMgR395SGuXJGm
	aTO7AsYYltxEblNh8JzC6XyoN3LDfM1fLBO/fFACY9g0atl9DPaRedlL71S+g2dVuPSwp3S3I/t
	BFKpmg6zYPjC0y+Hksx9gDvp1okF7QginGb6f
X-Google-Smtp-Source: AGHT+IFPrTWFaWzsN18ynBbOfrj6yKauy1rbW7JKosKMMVVRaNYQETiv1wgDZLXfoVbmYSl1ebWX/KyJ74+mf8oQl6g=
X-Received: by 2002:a05:6808:1a23:b0:3c0:3b90:ae1f with SMTP id
 bk35-20020a0568081a2300b003c03b90ae1fmr2355849oib.49.1707902713458; Wed, 14
 Feb 2024 01:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com> <20240213130018.3029991-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20240213130018.3029991-2-heikki.krogerus@linux.intel.com>
From: Prashant Malani <pmalani@chromium.org>
Date: Wed, 14 Feb 2024 01:25:02 -0800
Message-ID: <CACeCKaeosTp2gS+5oZO3rMCVa=sWSD+PeSa6a2noiv9foJ6sEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: roles: Link the switch to its connector
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	Emilie Roberts <hadrosaur@google.com>, "Nyman, Mathias" <mathias.nyman@intel.com>, 
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>, 
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>, Samuel Jacob <samjaco@google.com>, 
	Uday Bhat <uday.m.bhat@intel.com>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:00=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This is probable useful information to have in user space in
> general, but it's primarily needed for the xHCI DbC (Debug
> Capability). When xHCI DbC is being used, the USB port needs
> to be muxed to the xHCI even in device role. In xHCI DbC mode,
> the xHCI is the USB device controller.
>
> Tested-by: Uday Bhat <uday.m.bhat@intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
FWIW:
Reviewed-by: Prashant Malani <pmalani@chromium.org>

