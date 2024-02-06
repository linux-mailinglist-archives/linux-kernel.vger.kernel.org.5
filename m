Return-Path: <linux-kernel+bounces-55432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67F84BCA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D2CB22E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760B134BD;
	Tue,  6 Feb 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ix20IlZA"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732ED101CE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242689; cv=none; b=n8wADDoZfyfANo4Ij7OJwTkIKTlOtVWsjVVGVYxqXEpKaYHKcwXkVazhkUxHxutvsYn5qWtl1ew1+b/qoxG9SuShZpgeS9KYYIbvmq2/Cj7E4HpB1j7Vv5mxawMI4Yr8g9nD5lhnAZxKGdfRxk+vFC1pIEdM2ecME4Ho8H6kZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242689; c=relaxed/simple;
	bh=LHhTCuH4A/0wFtRKTVPMRZgG2il7EIGIfjfqz07u/cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gwq6yD1UIUyhJw2QFyrOECsRFbG8U8lNy2k/xPI+Hew1qZ7dykzrhzXZjubmJNQggkOve9Xr980hxiW7I5sHc+Cc3KipAjjHJmIohUvt6XM3QACnvEBmwnjRPs5IPbVOQn5ECvR1d9tL2eVfHMeqi/wXm19xSNYtF4yNvnbGVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ix20IlZA; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6869233d472so30378986d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707242686; x=1707847486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHhTCuH4A/0wFtRKTVPMRZgG2il7EIGIfjfqz07u/cI=;
        b=ix20IlZA8Du6dARbz/uQ9oJv3f5fy10dOqo7uaLtVIGyXq9jtNgYd+jWgCN+/Ab0Wx
         C/I1U1FCK3DVSPMCHcvCEDzWKLTBe3lVpznbY7PH3fzoQn0cy43hbwSG2ZHe887+UbN2
         bP5brBgWGMhLLIJVT9izhI9W/yevQzh5Jn8jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707242686; x=1707847486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHhTCuH4A/0wFtRKTVPMRZgG2il7EIGIfjfqz07u/cI=;
        b=nS+bLcw0kyNQ+7URGa4FtBYHACV4ZPFfBOWsT8NulKafBKePLCFHgHym6xHYXUOJnp
         J2ipn4YQ+C63yyowfiSQJbPh0BTpdd2G2PNXkRyKxoYTIglqDMrky4AuHottYkEB1JKm
         0DvGS3gNWDdvugBGGMNvGnDbmFhKIbt9fVb/1IxyNQMDBoQNsYkaNOAamhvh/JpWHlUu
         YTfyhLL/xmnei1m+KXTHfy3uw0WqDjUUTnjoy49tWiEgc7MdLbaKFbnIs45B2oniGRea
         ZIplxbaDZRSVjfDjqsWU+rt+XXkNqtROOXKpvZ/al++yekmhECRGrgeHzK6xVj3ZK/hc
         FaRQ==
X-Gm-Message-State: AOJu0Yw3E+vxxpFicVLfZbadGHFWtX0XKuY7otr2q/Y/zDGvejbh9eDr
	hEO0D8iuGI/TT+T/aNmEH0uFtBO+8Dp01MDWXRH7XCiCbONxDvJ71fxXArNpyfXPIA6Ig5cYvUF
	B3No8w4yfT9XhkQR4hXRBwYU/C3njvILRp7Oi
X-Google-Smtp-Source: AGHT+IFUlTRnDijctSI2MtUfRs5X3q8MZ8/UBu5rOlOOICbk1W0bwDf8CTes6qhfmyTO+dacWNRZQ4t7SBk3NvQeld8=
X-Received: by 2002:ad4:4ee1:0:b0:68c:8d67:fce0 with SMTP id
 dv1-20020ad44ee1000000b0068c8d67fce0mr2870871qvb.26.1707242686276; Tue, 06
 Feb 2024 10:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
 <20240126103859.v3.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
 <CACeCKaeVtU3ckmGU932d-pPn=eOnt6KjAavNY3rSOUgrJNriDg@mail.gmail.com>
 <CANFp7mXOXc6TzLJ+EJ9VYxqGHcjW099oBhDctarUdM5eJGz5bg@mail.gmail.com> <ZcIHePkgN2in5AAX@kuha.fi.intel.com>
In-Reply-To: <ZcIHePkgN2in5AAX@kuha.fi.intel.com>
From: Prashant Malani <pmalani@chromium.org>
Date: Tue, 6 Feb 2024 10:04:34 -0800
Message-ID: <CACeCKad_ODKKa1QY2O=VOdYZ0MHOrLH5aOte_bPaY-10aRh1YA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] usb: typec: ucsi: Get PD revision for partner
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, linux-usb@vger.kernel.org, 
	jthies@google.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rajaram Regupathy <rajaram.regupathy@intel.com>, 
	Saranya Gopal <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:18=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Abhishek,
>
> On Mon, Feb 05, 2024 at 02:05:38PM -0800, Abhishek Pandit-Subedi wrote:
> > Hi Heikki,
> >
> > Friendly ping to review this patch (I see you added Reviewed-by to the
> > other two in this series).
>
> I think Prashant said that he prefers macros with those version checks,
> and I kinda agree. But I'll leave this to you to decide. I think
> that's also something that can be improved later.

Yeah, the macro strikes me as unnecessary here. Anyhow, for the rest of it:

Reviewed-by: Prashant Malani <pmalani@chromium.org>

