Return-Path: <linux-kernel+bounces-83247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D48690C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB311F26780
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D141386A0;
	Tue, 27 Feb 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUXpD7UM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530084E1C9;
	Tue, 27 Feb 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037627; cv=none; b=FL00pN7dLJiCgARhGRHBkc7sHctAMhiOk9EmgWagDllRcSoNm8p7nvh0UaH7tp4bnFvmDl8mGf8qZ3/VN97J+GBowJC9Cgi8hJjffNDJk8YhqB+TlY9Hj7jEMTKmFDqVCv2kGazQP0jHrA3n7Wl6FER4+aZAHLqJbce4Ji2xtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037627; c=relaxed/simple;
	bh=4zJjHVcptMKGc+hFgx7D5SAukwz7yawFk+xDkB/Py4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sKXYE8vL/ybANn4IhIq1qKqj7EJBczKoAw/hteDWwSRpa79jjcodlmB7nhxIb5QNVslBWE2HiQogDc3UiN7wPTe1mlVllR+wp/DlQ+P16IwOd9hGRzUEZX9kiFo5QtyHr5zxNJ1agUVI1/SG3qWMaHccBEgFpJIt+ukfSsXX0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUXpD7UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDDDC433F1;
	Tue, 27 Feb 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709037626;
	bh=4zJjHVcptMKGc+hFgx7D5SAukwz7yawFk+xDkB/Py4Y=;
	h=Date:From:To:Cc:Subject:From;
	b=oUXpD7UMRxUc6WK2I+jo3QEw7Y25GPBMfNtWVCBism4ohrDV/ZH9SxfzYyAOF6ZiF
	 7CjPLDlNjDquv5OEvQgRKFu68KjjOeq7wKWZty70p6ccb0wkpOfW35KvATwy7reCYT
	 hJokEChlGxZBjxXx01PYulU6G6LCpvIIF5bBHsQeyqbaRErjgb0YQvI4Dd/gyet9y6
	 SK7rpCWxr9FcC/BHtNTFTDKBCzYE6XiRmlyAuS23R2ElO7ykqYzJlKCntIRr79KbYP
	 zSIJy76pgczWKKx09WGkcQ2yXkZ3dVGjZam0L69zENZmMUHINg0j3botqASqfvq/m8
	 OsNl8Jxfs7IAw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rewl2-000000000DS-26x3;
	Tue, 27 Feb 2024 13:40:29 +0100
Date: Tue, 27 Feb 2024 13:40:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drm/msm: VT console DisplayPort regression in 6.8-rc1
Message-ID: <Zd3YPGmrprxv-N-O@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Since 6.8-rc1 the VT console is no longer mirrored on an external
display on coldplug or hotplug on the Lenovo ThinkPad X13s.

The hotplug notification appears to be generated immediately but it is
no longer forwarded or processed correctly:

[   22.578434] msm_dpu ae01000.display-controller: msm_fbdev_client_hotplug
[   22.953161] msm_dpu ae01000.display-controller: msm_fbdev_client_hotplug
[   23.095122] msm_dpu ae01000.display-controller: msm_fbdev_client_hotplug
[   24.185683] msm_dpu ae01000.display-controller: msm_fbdev_client_hotplug
[   24.186197] msm-dp-display ae98000.displayport-controller: dp_pm_runtime_resume
[   24.188098] msm-dp-display ae98000.displayport-controller: dp_ctrl_phy_init
[   24.191805] msm_dpu ae01000.display-controller: msm_fbdev_client_hotplug
[   24.275904] [drm-dp] dp_ctrl_on_link: dp_ctrl_on_link - drm_dev = 0000000000000000
[   24.276474] [drm-dp] dp_ctrl_enable_mainlink_clocks: dp_ctrl_enable_mainlink_clocks - drm_dev = 0000000000000000

as the external display remains off/blank.

I've verified that reverting commit e467e0bde881 ("drm/msm/dp: use
drm_bridge_hpd_notify() to report HPD status changes") fixes "both"
issues.

I've previously reported this here:

	https://gitlab.freedesktop.org/drm/msm/-/issues/50

Note that a couple of times the display was eventually mirrored after a
very long timeout, but this doesn't seem to always be the case.

Johan


#regzbot introduced: e467e0bde881

