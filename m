Return-Path: <linux-kernel+bounces-77226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27C860256
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B91D1F21B44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6971722;
	Thu, 22 Feb 2024 19:09:38 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAE2575B;
	Thu, 22 Feb 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628978; cv=none; b=EiAFsjMTjmH5dAN/pJq4hJrspHOfZWdnXYEMf+h5dEHq6zmz0KLaCIdYkObhQaJJcq9ay4QT+vLYGY8rBitzcK5sOINawwMPx/bjDIVrPeFi1f9xLyHyZ/2tv9eGUDotq7fOZTi2Ao1EoicfintQGx1dFCheGGALUDtSh792KEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628978; c=relaxed/simple;
	bh=mI57a/fFX3uiYjIsw96ouRhYjWUvg53pK3eC7aGFRcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7KEzDbGNB2Uu9xdChu8v8LD3K0lXSM0A3WgDwNH17UjXoVwdRV2NaID9md+iIfNZtprZvl4wfaNeyVJM5kcuaHYt0nrPOSGWlAr2ZeJZF37uWzyNQZtFSTZmAdu8waIWCdiu4M4O19cXrE2NwQKkWubz+Mh9+Y6nOTR5prEpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59f9045d18dso14793eaf.0;
        Thu, 22 Feb 2024 11:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628976; x=1709233776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI57a/fFX3uiYjIsw96ouRhYjWUvg53pK3eC7aGFRcg=;
        b=Yu8cqUnOH8S0eKYiO25FkdhUE62rBjCey3P7ZKuJL8nguRT8IlpC+mP9HWEvruK62p
         oLNbcG5QcvOlFyVNGd2IqTcBcQI5/KSJdfuwTvHu0/k1Pgna7VfkqctkGac9It8QyIlh
         hAjEnGJ3tWOOM7rMupm6yBCrQJflXhpp4iPiLEib6D6kRhUU0JM/32CRNCLzAmAFFs5k
         on4VTQMY9h61c379v4wZAYoChvUc/L1W3kPK3uDHZPhPLkJvwlqXWuKwFrqDVEQixAbn
         /XsExkyGF6QeXl6YHFSZlOV9eIYGPu2LATN2PEuce+V9EAOTmC9SgTPjYSrQY41fPjz2
         TZqw==
X-Forwarded-Encrypted: i=1; AJvYcCVuAvg7A0ybsNkgFO7qdH109PQyM1Nsp0gpJJJK4wWnbg/tAhwykmZplZSostlHuH9WDaoa8qQIudVg+y1Ja4l8i+DGgEOFzTcCE0yeD0MpsymtOgFw9JH6xeV4faO/qwnaplPF0BIgj06l6magRabEDm/lv483bEP9VMkzbtmP9A99oYMgkj8=
X-Gm-Message-State: AOJu0YzYppUEhoR8pd+VGtOzZ3gMSD4sIoOLT4MkCm12lJ2hpK/BRR6f
	MboJ3RyNwxrJ1eGrm0QCWckyZ/0cYyImoPKPyVmDbZxVm1z8q6xlKG+ni8rBb3fYHH3gI8mQsJ1
	+vxI1XRzDMlc9O8xj7iEYdgqLqeo=
X-Google-Smtp-Source: AGHT+IETFoK7T6C1tnmiR90r6kea/Z2OWg9BazXFmeAErs0t530tnUL62eTa+Y7FdI3dCEbLLbKs2EKUr5DCNNZAP5I=
X-Received: by 2002:a05:6820:305:b0:5a0:1c1e:a8c2 with SMTP id
 l5-20020a056820030500b005a01c1ea8c2mr4929393ooe.0.1708628975933; Thu, 22 Feb
 2024 11:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>
 <202402180106.25E08136F5@keescook>
In-Reply-To: <202402180106.25E08136F5@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:09:24 +0100
Message-ID: <CAJZ5v0jbPvP6TfF9QS5szaW3bfGw6M=kzOFjTDAOjKHBiWNdrg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Don't ignore return from set_memory_ro()
To: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 10:07=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Sun, Feb 18, 2024 at 09:40:58AM +0100, Christophe Leroy wrote:
> > set_memory_ro() and set_memory_rw() can fail, leaving memory
> > unprotected.
> >
> > Take the returned value into account and abort in case of
> > failure.
> >
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> More set_memory* consumers! :) Error paths look good to me.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied as 6.9 material, thanks!

