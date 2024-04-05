Return-Path: <linux-kernel+bounces-132351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287BF899370
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5A31F223F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA47018C3D;
	Fri,  5 Apr 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btt669Pb"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76366168BE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285703; cv=none; b=TMqO2+vCCA+NWo/BzWQoNXoIDBTpEFzORjPdD6bIdL0hQkPvzfVAaSnTCb6LDC7hTq2nctFIxQbHClnb9nnhdTn0oCxWqBjY1ZKgCokONmIY1XHgU3DlX2/j9OjpVYmv4ec8F/yOCLfRBkwHiXGgZNIXbRmA92CClTzidvvnXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285703; c=relaxed/simple;
	bh=YdWgYZZy6+ImQbZGCSH7do3YA/hmyop0f165eRYq+Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3qpETfUJ5+8zE4XLq3a4cJJk4y/u2k2xGEgQ+Fpi2YnJzw6uSzmq0rqLs9YXoI6CqpYSrjqU0TiT1WYBy6IKEKiI0hPjM+4b4E8gFE4BGTQRLO5w5AGX3Z9/Q1BTwzalYgRPZhB74m3kX8xGXlkFPjCqODG7gMNfpnnpRdefCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btt669Pb; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1432498276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712285700; x=1712890500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EfDPM/jBlrvHW8pL/mwrjjQGf0cytLyBW2ZbeZaxa8w=;
        b=btt669Pb8VLcPK1DnKNJJ/+DQD79ZSQs+HDS4IoNHnJMNCt8X5fT0SFJindBqQu71S
         wzrSLhlYZP/Onm4G8PEmPzRGZ0XZIxgXho02IHI6t9IffnR/BsQVt/KHiSVCjpEMoW+Y
         VQvOyiHWevAq4j5K5sOvBJWI7kGey/Yvfu6LAklMfF7z+8RXOoRlxDghi9RW8GQw4KLS
         ZVlIoLOI9yYhho0Prb9+SDY9GuJbSTZ0V64B8fupMS/opHTSjgVjFhw4tVqrDkmaTPQZ
         Tu+OblJrjgsxRQXuE1Ha7XysbFaUHhFUkeypqW79X0VhuwbTj0MK0262NB5uOfjLplO5
         yjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712285700; x=1712890500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfDPM/jBlrvHW8pL/mwrjjQGf0cytLyBW2ZbeZaxa8w=;
        b=iCN+Ls4QvLebifzOv0h5tRzI1LKChI254AtBlfyl2143n7WA+FeKb5u18FgyFxrmRA
         JjlcpjX1k+JdV7fs/TEvbYj4Hm0Yn9sd7bqjgHeLDB1luVnH56j/zwyUowBZgtFIC3uM
         BCsBJBN3t40m4umt/C7+IxmJacGnHE6G1UdliQnrtaLQxKJGv5e4+Z7L3+6Euc0JbpHx
         Qk2orECfjouKnFu6rJmDVhu547U1oAiC+K74KJWGNI/Eawenq6I2gcbAqOkGwtMrDjXY
         REPgsn4NBEJtYeW6HVvwEuXGxs8BvbcvE49Nrt0P6x8jTsRTLoA5SiYocK0Yqc+D/0r/
         Ykqw==
X-Forwarded-Encrypted: i=1; AJvYcCW/vwtHBCmIoXsN+DrRRqQGA189mbbM2dxTISep/5ucBRk1OvZI/v9cQTLZvD2Wyw4sgXOQKs8xPbCjWdfky943x1Q8XoXR3/brY680
X-Gm-Message-State: AOJu0YwOWkG0NVkdVULIY9gsw6qDssTsu01fzBFxyoYnKJGRagzG2arj
	qpTtCMR1uwvZtVIh4lzBtZD6rRB5iQFLqSc0HZtt/OJQC5QzI52zIdFsbmhJcNHEmtOeihTmsDw
	X6DV5ZywwqjnPU09GdDVtlqCI8FWsPDlppMrSNg==
X-Google-Smtp-Source: AGHT+IFivS2hB8z2W9hwonWTCxmRcOXhWI/RFcC0uZQ37FAI9e0SKdalGASHEiDclHq2P1ZBRA6kcdGTvgLJPN2UQoc=
X-Received: by 2002:a25:dc92:0:b0:dcc:6894:4ac0 with SMTP id
 y140-20020a25dc92000000b00dcc68944ac0mr207083ybe.20.1712285700487; Thu, 04
 Apr 2024 19:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404234345.1446300-1-swboyd@chromium.org>
In-Reply-To: <20240404234345.1446300-1-swboyd@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Apr 2024 05:54:49 +0300
Message-ID: <CAA8EJprZ8Ehx+M7vy1pH8OT6Of2v8-trecCJZhF5wxBRSGQoXw@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix VCO div offset on v3
To: Stephen Boyd <swboyd@chromium.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	freedreno@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 02:43, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Commit ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to
> setup clocks") changed the offset that is used to write to
> DP_PHY_VCO_DIV from QSERDES_V3_DP_PHY_VCO_DIV to
> QSERDES_V4_DP_PHY_VCO_DIV. Unfortunately, this offset is different
> between v3 and v4 phys:
>
>  #define QSERDES_V3_DP_PHY_VCO_DIV                 0x064
>  #define QSERDES_V4_DP_PHY_VCO_DIV                 0x070
>
> meaning that we write the wrong register on v3 phys now. Add another
> generic register to 'regs' and use it here instead of a version specific
> define to fix this.
>
> This was discovered after Abhinav looked over register dumps with me
> from sc7180 Trogdor devices that started failing to light up the
> external display with v6.6 based kernels. It turns out that some
> monitors are very specific about their link clk frequency and if the
> default power on reset value is still there the monitor will show a
> blank screen or a garbled display. Other monitors are perfectly happy to
> get a bad clock signal.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to setup clocks")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

