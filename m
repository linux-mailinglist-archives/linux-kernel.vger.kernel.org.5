Return-Path: <linux-kernel+bounces-63868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB08535B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD03F1C24CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A675F568;
	Tue, 13 Feb 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qja8H6lH"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5B1DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840618; cv=none; b=ZKmFnyvlO6xHDUACcTHsKIV5s0kltYkQLwUBieOGSSe0+WsOKdqI492Pw3zfcXTO4WedNGTufCCjixFP0z42kfwpoSQCNPjhQciN97ZXgJAgFd3Jg11G4KFW9e1IxxmbQVropCuKDfjbx+F1dUPfJIecH3MwckmfcnANcXTUMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840618; c=relaxed/simple;
	bh=xJL8vKZhwVb6WSeqq2IUecntKTJ7Z6FCRy0pbVYVj34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUf41nlFaE+pWYF/bM5uDPj6ErfdJ0iV/vdRjmNGtN/DcYInnYsa7cvzelGQWLNhWxvh5JvZB5OuxXGyvPBTnMvSlK3NuQiyZUR/QiL2qONcnHxe+TyU1ka6MlrL/FiYaq2aJjDi5Qb7XdCkEjlC2hmLjAZooYVhWm3lHI69zr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qja8H6lH; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51167e470f7so5517524e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707840614; x=1708445414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJKUUFTA0CdrHmvE6Ug8SOMjnvae40DHkRJftVt5u48=;
        b=Qja8H6lHuQm3CoXpvvnjgHUmTWBFxuRThn7T+u1sJbOuRJXtiTyJwrMfIFbLgcw5eu
         vNaIlml/MMkmdyVvF98VIfqoOWNTXhyirljRYQzMRhBYhg9bPwGpE/lJZO2jGHtt4u56
         C8CownUWAUveJAN5ZrylRsVFnnI/aUzYCCP5VUd4J4Ssqiei1XlZaoGF7UBRSQ2NOUay
         FHO8KtClnAxWayPUMT6D13Ye3f8RyIleoanLQsouXPhPZynbid+jgE0o/ZGxBhOMjdLv
         3hrKrmthNGh8ilsVXeG2EOPDr2eqWuXCJUq/GyVKABK0O4Z3/Pt2YW6Yq0H8hpOLgpGc
         m3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840614; x=1708445414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJKUUFTA0CdrHmvE6Ug8SOMjnvae40DHkRJftVt5u48=;
        b=mKYbSC6BFAtTxQ6Mj+c/oxk70kKxsH1h7hZHlkT5vySBlgc6nlRzUmzLBRp9v1n5Y7
         dKtWiIv5OEVOn5vBDypfJqt5zmAflOEexeaHCaiyENVYkn4JTPYltEfZovy4GKLqK/nP
         gByVFKBQuGwlzVU8+8Sp9UHwBhey/bGywPaJigKuZh3r6wGI33GctJYgKJ38LHV3NWc6
         rz8Yx2QkenJ2OmmuQg9huSLWskpav8vADNsS3O12iQE6kX5OVLHyqlFTu9+SwSrXVsNY
         4hHt4cxKFhi3HQhI3w5qGtyXkyFLadViZz92DKNyWKiX6FxE28FheueGogd3GKAdkk0F
         MVQg==
X-Gm-Message-State: AOJu0YyDaf2z+BYAvzEoFeZDOd8XKGO850FAb5o4YAnBzGZxYdH3twed
	xB2gkAEYjYzK2zRPdkM4oMq9Q0LMH57e88yAUQRErM/LlkQov+PpIDOFEmx4KVY=
X-Google-Smtp-Source: AGHT+IGTFXXW8YxjMGYY+oMpZFD6bzjHghivDo9sbaJPl7MZaFAbm+z+TRbkh7kxg81WPddiGa8jow==
X-Received: by 2002:ac2:499d:0:b0:511:9f5e:b7ab with SMTP id f29-20020ac2499d000000b005119f5eb7abmr439081lfl.50.1707840614357;
        Tue, 13 Feb 2024 08:10:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzJwQFlatJn5vWXcqUKBmGaKD++zC2qjQKbpLATzLJqfmp5P8ISl0NSqigQszPM1+H6u7XziMNpCCCTswN7UMGJG/EEZ3P/NNk34YUTRSmQ6T2FXuTwS7YU+2f15NdCSx33k9pp7hJJlSMunmeF6XH+wUvE2N00/ja1mKkfIufNHOdVwCSSFFEi1oslnu7dn38tRI/YyOYd0QumhqDOwUqx9FCkIUc4ae7WPB274fOoGJQWMhUbvDNuEHFwYbxnq4Kv/ozLEVKAk3SQyeCU/3aoGSkat9kHsqPzXFFxyL8FxmVXkkzWgCk
Received: from eriador.lan (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id t16-20020ac24c10000000b005115317395dsm1316102lfq.7.2024.02.13.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:10:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/crtc: fix uninitialized variable use even harder
Date: Tue, 13 Feb 2024 18:10:11 +0200
Message-ID: <170784060080.666897.14996571723108482636.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212215534.190682-1-robdclark@gmail.com>
References: <20240212215534.190682-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Feb 2024 13:55:34 -0800, Rob Clark wrote:
> DRM_MODESET_LOCK_ALL_BEGIN() has a hidden trap-door (aka retry loop),
> which means we can't rely too much on variable initializers.
> 
> 

Applied to drm-misc-fixes, thanks!

[1/1] drm/crtc: fix uninitialized variable use even harder
      commit: b6802b61a9d0e99dcfa6fff7c50db7c48a9623d3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

