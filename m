Return-Path: <linux-kernel+bounces-20912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1433B828746
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F6F1C24101
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7D38FAD;
	Tue,  9 Jan 2024 13:43:07 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474E39AC1;
	Tue,  9 Jan 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59882f48b50so40033eaf.0;
        Tue, 09 Jan 2024 05:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704807785; x=1705412585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUBKGHQksFVMti/JUe1/BJ0a1FzKN9fSs3uKM7tNhAo=;
        b=VpD9jWWFy1R+UBGaXFbUyT+MXZn+9Fc3RaD7AQpxKkYDu5IAednqBR1f/hxQPoeBhD
         HmswkzoOYYulVLVTaPDnpmwoXnssU5NK0Q6g5WOSzl3MPSLe15J58D5JSHn1faHy8WM2
         UgqM3YMi5ojwcYd1n6a3HXTP5krp96ddfk82O322lZ7u1bnaSf8oOjVEcNm1N/OGZWnH
         9NKB8PX/gf7AXtLhXsUajSL1mcthrMg6NfTZAkKf9gSVPC6og+gfIO1LNC71lcjIUnhc
         G3KHCTwTLFtDzz0t43+8Qw9Zt57NvhjlsDRZjmLPWAQBOA7CJnvKRMIDFnZ5ejTmLQAn
         DYUA==
X-Gm-Message-State: AOJu0YyoSgoSMWmoLlUsGr016Q+JgSoQH+Li/r2GY+JFScyCxUQCB+ba
	qKmDw1plMjW2gM0058MvRI55Dm8OSkmQaajmvgA=
X-Google-Smtp-Source: AGHT+IEEPq7LwtGehhfpeYAwVQOSkbSV72Vly1RZhdtZmimllq3N6G93gooFUh7lgLkjOu4ZSJJKrcMnez+4Dy0fcoY=
X-Received: by 2002:a05:6870:418e:b0:205:f07d:344a with SMTP id
 y14-20020a056870418e00b00205f07d344amr9580257oac.5.1704807784366; Tue, 09 Jan
 2024 05:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
In-Reply-To: <20240106191502.29126-1-quic_manafm@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 14:42:52 +0100
Message-ID: <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 8:16=E2=80=AFPM Manaf Meethalavalappu Pallikunhi
<quic_manafm@quicinc.com> wrote:
>
> The commit 2e38a2a981b2("thermal/core: Add a generic
> thermal_zone_set_trip() function") adds the support to update
> trip hysteresis even if set_trip_hyst() operation is not defined.
> But during hysteresis attribute creation, if this operation is
> defined then only it enables hysteresis write access. It leads
> to a case where hysteresis sysfs will be read only for a thermal
> zone when its set_trip_hyst() operation is not defined.

Which is by design.

For some thermal zone types (eg. acpi), updating trip hysteresis via
sysfs might lead to incorrect behavior.

