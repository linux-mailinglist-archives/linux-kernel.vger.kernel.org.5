Return-Path: <linux-kernel+bounces-59220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC73984F35B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261D31C25B87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF069308;
	Fri,  9 Feb 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2utyLbyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366969300;
	Fri,  9 Feb 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474168; cv=none; b=CCvhSqyYXWPal7Sz9s+j1nbSjiCg9VqwkQCX4U9FGhNM7nJTcwq9SDYHD2W3WXVP413KICervDihr+fcVVzDnjXORzi53gaGIuVFZEEchIf7lcJw7ovVSMVZgCdkymLwnsG4l/WjNKTGocaOCzPH/JlU/oNbq+qDRBRX4q8TefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474168; c=relaxed/simple;
	bh=cs5VZ4iM5HdhEgJi2Gu/DOwpKJdiVGb7uaKztxLeeN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1Q9n6UNtr8I/0noHh6uu82/OIynkEPTtzCqlvIPJvK6QFJQjpluyzrAoUq8ThxLeFlvSHpeLXPqr2oBGLCAAZxrreizEpIpgGJBhfJtvZMkNOkexy4+FJB/MjZIcYAq0ANjbghgYS7kQ/ZiMIn3pTN3DT/PYC/o5b+NR7/1BAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2utyLbyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA98C433F1;
	Fri,  9 Feb 2024 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707474168;
	bh=cs5VZ4iM5HdhEgJi2Gu/DOwpKJdiVGb7uaKztxLeeN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2utyLbyRIR+omAGgzPLUuILSYLG35BqhO8gkXzWOvxSl76YEuBkYa7+cDmAl6lMSt
	 mdwN7bSRtzSCd10x9pn8vEO8VnAkR3OyrtDpDSsMCZ881TATKJh0o5dQ/ft85GYYmU
	 YUGytVxSQMjVhXhjiu4+WcTfmT5X2mbQQUTpeI/4=
Date: Fri, 9 Feb 2024 10:22:45 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz,
	conor+dt@kernel.org, corbet@lwn.net, lgirdwood@gmail.com,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
	tiwai@suse.com, robh+dt@kernel.org, konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v14 01/53] xhci: fix possible null pointer dereference at
 secondary interrupter removal
Message-ID: <2024020931-unelected-scribble-50f4@gregkh>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
 <20240208231406.27397-2-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208231406.27397-2-quic_wcheng@quicinc.com>

On Thu, Feb 08, 2024 at 03:13:14PM -0800, Wesley Cheng wrote:
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Don't try to remove a secondary interrupter that is known to be invalid.
> Also check if the interrupter is valid inside the spinlock that protects
> the array of interrupters.
> 
> Found by smatch static checker
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-usb/ffaa0a1b-5984-4a1f-bfd3-9184630a97b9@moroto.mountain/
> Fixes: c99b38c41234 ("xhci: add support to allocate several interrupters")
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Link: https://lore.kernel.org/r/20240125152737.2983959-2-mathias.nyman@linux.intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Wait, this is already in my tree, right?  Why keep sending it?

confused,

greg k-h

