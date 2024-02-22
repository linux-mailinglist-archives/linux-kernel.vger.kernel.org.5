Return-Path: <linux-kernel+bounces-76177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE985F3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304741C2278B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC730364C1;
	Thu, 22 Feb 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aurpqPyx"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9A36AE9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592685; cv=none; b=IoRajnbqStwmzHoOYpmyPNfmk26J0QBqn+efvNlmPWMdR9Pw3II+ay06u2v/wyI7TeeL293Ggh5FObSW82t4RLYZwV1mq0QWgAolaUMgQ4+mIFn/h3ZonkrSMlmsTY2H5HR3aS9HEjrpuMGBVb7eEj6fs8pvI5bjm8tPEVbRgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592685; c=relaxed/simple;
	bh=wLueoCVw90PVM/vBmomzRcuwM0Q1+H3Jq2XKptthl8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rewXoBWuPGy398o2493OY+LqL6Jjqhv4gkQgjaTY2qHvXEqvmCrbdx7A5UdjdTQeo0u4jChFSXzrupo4PHEmdT7zQHhTOg7CTpwqHboUjDwGqKbOGefwn2WLdeHrZitGWSdgiG/GnjIsaXB5kQScZmGV9AsoyxQ+A16PPE2gn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aurpqPyx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60821136c5aso33295437b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708592683; x=1709197483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/TPJbWbUkPAf8/OgjM4Bs/DBnfD95CuyEz8cKBKIieU=;
        b=aurpqPyxaLJPK6Qjr4H96kJ53s/xlo+1DQBlMpXj8tN0i1fsj+Qfe7F8KZPp4dUWnM
         K/2OvvanZtXvoKKB+YqTU8JPeKYFB6MkquN8KLhmUg1iOJPfuIvXipEoPxWfKneRKFG8
         70bPOWD36221/VdGO4nCW0qmTrLDUGitpc2RQWGxDzFLZbJM6YDIkdbkdDhXj4zqiiZE
         AF8Et4JYk/LHTiWUDzBFk1Pw/qW1M/q/gSIPGl8lChlfrFbRF1qR0ygSV7nyj/XPsHt/
         JKSF70mDGGRO+rQKO69Sg3htMgTmDe2qqy06HUP4ILrTaX8Nymsw6dD4FbOYr6NJN+gV
         xCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592683; x=1709197483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TPJbWbUkPAf8/OgjM4Bs/DBnfD95CuyEz8cKBKIieU=;
        b=C5dAWRytTjmu9pZybBA202vp1gEXPfQhAHfPkoukNjZYcryz2XzAkpMSSUFpz9a14I
         Lor1QWgzUgtKi5G72f+NBkrtTLUtD+YOXkOvh4O9G61AvNj2WpsrW8foH7F2dMrFTkUy
         sgn6yZlbbMYOZw/zW84hrhwIsAwDnZWhx8AqnE1F3l3c+hGKYKb3hsdJq+Iyjt+gOUdG
         YxsF33wl/mjqndd+U3vWPTdMaZ6WMriahsrCwmjSBmLYCUQ6Gk8MUZUmpX/UJ4XAC7Kf
         quvCgerA9XyMBHZOum3x5ns4NpWVhnR+u8MZfxvjAbRPJcKBtlHp3icTZKlH01nrrzp9
         J8iw==
X-Forwarded-Encrypted: i=1; AJvYcCVre4y1nV4ASC0tt6ZdqoDm21c4h8bsF4fvC5E12+2UmNjBrJaj8qR9HZX8s4+Ho3/V1yqoiqBaJeni26yRfKyNjtETvGXnXaEdJ+nw
X-Gm-Message-State: AOJu0YytDOGuieBoZGCXbIP92l+74VXFWO/oOVOUYS2D5H/Hi+rt/rSt
	Z//IEvYpyT0uwKabyIl9PmNYyX/CgWq/7CMZCME6xYf3bD7CzoW0/wxFuPasE8xAw4i0jTkxyWA
	zcw/lfh21vyY3Yn0Iin7NG51zbxnw0zvhsaHnfw==
X-Google-Smtp-Source: AGHT+IGh4PQ6sJzEBbpokmVQdqBTIm/+xR9L/veKiiKuOpm6XOQARzpp3TR3D/xAbTVR/A369Z/Zv2cdKDbeepxT0hk=
X-Received: by 2002:a81:a193:0:b0:608:3797:5ac8 with SMTP id
 y141-20020a81a193000000b0060837975ac8mr11133955ywg.32.1708592682743; Thu, 22
 Feb 2024 01:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
 <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com> <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org>
In-Reply-To: <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 11:04:31 +0200
Message-ID: <CAA8EJpqFj5nf8d_=Uoup7qg+nQrxqQU-DHbL3uSP138m9AcXLw@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, Douglas Anderson <dianders@chromium.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 10:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 2/22/24 00:41, Dmitry Baryshkov wrote:
> > On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >>
> >> The max frequency listed in the DPU opp-table is 506MHz, this is not
> >> sufficient to drive a 4k@60 display, resulting in constant underrun.
> >>
> >> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
> >> fix this.
> >
> > I think we might want to keep this disabled for ChromeOS devices. Doug?
>
> ChromeOS devices don't get a special SoC

But they have the sc7280-chrome-common.dtsi, which might contain a
corresponding /delete-node/ .


-- 
With best wishes
Dmitry

