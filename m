Return-Path: <linux-kernel+bounces-66455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D427E855CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F881F27B58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D494413FF6;
	Thu, 15 Feb 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="f8l5bkiC"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2513AC9
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987243; cv=none; b=c0qbgjRVf0cKSwklgncMLbCHTJXZty+iNxpzyAGaUcQmTx4dkEowhlbkAKsceHJk15/7nyx76/Fab0MUsMDhBmAM3ISRjdQjdPf+QfDQxRb2cJw8NVBpYIEqAWXyG4uswGte6dusWcFGCoRy7JaG8w9nToinRnIJRz0nj0YgvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987243; c=relaxed/simple;
	bh=BxhXWXZiB+Wfo5v9GbFl5z0+NuPKitm+wWFHR5UIVL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAiT2gDPD6S1bPrbZvuWHcDU45pJaDYmpTAMsAG0r1iuRQPl1JVM70IWnOiiq6MKWNSkpNoy8LjDeR1w6CSogRUQ6FXNWbHnubCcTzAlxC8JjrQuejHJG+GAn1TEz0yn+abiXEC0XwxNkuajSiihGm8GeqXRux5H6lssDKY0q1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=f8l5bkiC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0c9967fdcso18324201fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707987239; x=1708592039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxhXWXZiB+Wfo5v9GbFl5z0+NuPKitm+wWFHR5UIVL0=;
        b=f8l5bkiCQgbB0W27hDo+lCFviP9dbIo1szyoL+6akCAQP3XuY+L8Nbmb0+pP/U1s2k
         6Y0CEUqOZ1l7Skdk2I9zCa5ZYtZFpYan+V85QcaEDKTIaq/1YL+YXUiseu7ey19BermK
         XzxEBy2mgJOrfHbULzfut188ClNV57SFL4FDfEopzGvVryR3NLxDj0jOsZcLSDp8R8S4
         EtGvgrZp3SBJGbt0DcIu5wJ1SNYrlGrIuOHAPXUTStL4eDJ0th1lOJI+kCCP6kwzD4PO
         wUsG1V26r3bdfG0UfCVC/5ila5Mve0uQR+43DKPICm3GATlGQDHvkucnSVqtDXknOsT5
         OkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707987239; x=1708592039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxhXWXZiB+Wfo5v9GbFl5z0+NuPKitm+wWFHR5UIVL0=;
        b=LN3cejp/zO81JFja0vN1h2uyq2KQhECR6zVBXWt3soGELYEFzZc8Ug1YfYWO9JnRhu
         lQuGMYKafz3tfpjDHZowde+xpHbLud5ydKmfd2cIyuAmPZC69N0S8HZrgpjHaI1kkD5p
         8dYp5mdb0l074f4+F1ksPHIawwwyIf4mYGFQaooLSPfioEGgkSFSTngT4yUDcTBrkksx
         ihAyN/LOp+LsEoA+tfVFTpKaLqt+f2yDDrc8MY8Ydosuua4UA6A/Yt1b3WhryLHAo/ET
         7OgZko6XWAUx7HNyDjh5JKJ/FDjbNVL2w9b0Tyw86q61Qx9h1lh4xjjvWURh6yas2Saf
         oa7Q==
X-Gm-Message-State: AOJu0YwalGnzfkl4h2LVFP/1gGu/ygyPCka8YAoLfMIR6Sdxc2mYKXVx
	jq2Vr8HSp9ZEDz2dHhTVy99/zj7rVtTKMnYrxhtod8ICLjxsD+AXRCktBuRFMTK54XThb1jki6C
	7MiBez/DHeQnoq+JfrJ1x1oAbl5d2g6UuOx+NqA==
X-Google-Smtp-Source: AGHT+IHjXc3MhGsHgD6GLplgQ12wq2mPS7drH66YKwMLKHXC6GqrZvVokxlqcWWvrvJwHzAAI2NQcsnXjgAd1wQLyoQ=
X-Received: by 2002:a2e:9d10:0:b0:2d0:af40:7058 with SMTP id
 t16-20020a2e9d10000000b002d0af407058mr359234lji.14.1707987239015; Thu, 15 Feb
 2024 00:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 15 Feb 2024 09:53:48 +0100
Message-ID: <CAKPOu+-Xy1E_bZMDJu8YQB_s235k3k3GcbeNNP=Vkn2aC1uk_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits()
 to wordpath.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The wordpart.h header is collecting APIs related to the handling
> parts of the word (usually in byte granularity). The upper_*_bits()
> and lower_*_bits() are good candidates to be moved to there.

Sigh. This was actually a copy of my patch which I submitted a week
before yours. https://lore.kernel.org/lkml/20240209164027.2582906-34-max.ke=
llermann@ionos.com/

