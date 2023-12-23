Return-Path: <linux-kernel+bounces-10436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C9081D45C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948E0B21EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E31DDB7;
	Sat, 23 Dec 2023 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX3jLz4N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36369D51A;
	Sat, 23 Dec 2023 13:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141ACC433C7;
	Sat, 23 Dec 2023 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703339911;
	bh=gvrM5vr0NZj7qhhuIEVRbaoqCKOSx1zd+UHnL57kz8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PX3jLz4Nf5VuCIOmVOMP5LOV0AQfsOxkhW2sNETgVCZw24rttTWrGKJONr7X+r47a
	 n+ZCiBYlJCdzW7Lrb2ishzFSA26r+JRhmr35o/uwlP8PT/BKD/pO9Gm+HbHQdQSJ0p
	 7osxh8U1Cv2ban38B36h5+qoz50gbIpvd/EV3ajU4240hP9tx0L409nAaQ5PMd6r1v
	 Q1XbftrtYxPXL58NXtIQkFgn8CRm9SuPBhlX++2+VSFVOMkJsuoT9rVfgJQBKIkEsI
	 zBVXo4Yrm4/72bfOq48vveuZ/MlRoMdd5f8XVL/SxahpdU7EY2jq0W7/o0QquCZ0El
	 uSk6WA+5qQ2Yg==
Date: Sat, 23 Dec 2023 13:58:25 +0000
From: Simon Horman <horms@kernel.org>
To: Sarannya S <quic_sarannya@quicinc.com>
Cc: quic_bjorande@quicinc.com, andersson@kernel.org, quic_clew@quicinc.com,
	mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH V1] net: qrtr: ns: Return 0 if server port is not present
Message-ID: <20231223135757.GB201037@kernel.org>
References: <1703153211-3717-1-git-send-email-quic_sarannya@quicinc.com>
 <1703153211-3717-2-git-send-email-quic_sarannya@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703153211-3717-2-git-send-email-quic_sarannya@quicinc.com>

[Dropped bjorn.andersson@kernel.org, as the correct address seems
 to be andersson@kernel.org, which is already in the CC list.
 kernel.org rejected sending this email without that update.]

On Thu, Dec 21, 2023 at 03:36:51PM +0530, Sarannya S wrote:
> When a 'DEL_CLIENT' message is received from the remote, the corresponding
> server port gets deleted. A DEL_SERVER message is then announced for this
> server. As part of handling the subsequent DEL_SERVER message, the name-
> server attempts to delete the server port which results in a '-ENOENT' error.
> The return value from server_del() is then propagated back to qrtr_ns_worker,
> causing excessive error prints.
> To address this, return 0 from control_cmd_del_server() without checking the
> return value of server_del(), since the above scenario is not an error case
> and hence server_del() doesn't have any other error return value.
> 
> Signed-off-by: Sarannya Sasikumar <quic_sarannya@quicinc.com>

Thanks,

I have a suggestion below. But that notwithstanding this change
looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/qrtr/ns.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index b1db0b5..abb0c70 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -512,7 +512,9 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
>  	if (!node)
>  		return -ENOENT;
>  
> -	return server_del(node, port, true);
> +	server_del(node, port, true);
> +
> +	return 0;
>  }

With this change the return value of server_del() now seems to be
ignored by all callers. Perhaps it would make sense to update it
to return void?

>  
>  static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
> -- 
> 2.7.4
> 
> 

