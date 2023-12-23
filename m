Return-Path: <linux-kernel+bounces-10435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887481D458
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FEB1C2102A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B21DDB7;
	Sat, 23 Dec 2023 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0USso2l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073D11CA3;
	Sat, 23 Dec 2023 13:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9BC433C8;
	Sat, 23 Dec 2023 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703339774;
	bh=402FMcsFLXTqiwyZScGBRIUGS4WdpQxLxaKJLbakZgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0USso2le2eZ6W5yiS3ameFhrGVcs/wFTu6sS4H3Wgws6f3HZ5DzD48BDmEX8+rN9
	 syg2nhieCnSpkaqNVqk0JAQ25LR3fAjjemoSbS1pArgN+r+aZrooNJEQG7e3sq9Kro
	 obtuHJ3VclUqZyHYEbkfWoKo2lby9oGtn6zDZSvZM7zC2cOtSI8YlmbdqhHlR8w/TJ
	 reJ0Hn9MeXv5xHTyHflitfMw8Imdiu4hDmINru33Mf8StPuW4LvcJII6YhoSV7E2EE
	 yIiQXCOcqatX9WQA/OGzUMgBlV/SyTx389uNpOZmF0GtV+JUv+rLzgpG2hWqXTgIaA
	 D6w062dsJGdBA==
Date: Sat, 23 Dec 2023 13:56:08 +0000
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
Subject: Re: [PATCH V1] net: qrtr: ns: Ignore ENODEV failures in ns
Message-ID: <20231223135333.GA201037@kernel.org>
References: <1703153211-3717-1-git-send-email-quic_sarannya@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703153211-3717-1-git-send-email-quic_sarannya@quicinc.com>

[Dropped bjorn.andersson@kernel.org, as the correct address seems
 to be andersson@kernel.org, which is already in the CC list.
 kernel.org rejected sending this email without that update.]

On Thu, Dec 21, 2023 at 03:36:50PM +0530, Sarannya S wrote:
> From: Chris Lew <quic_clew@quicinc.com>
> 
> Ignore the ENODEV failures returned by kernel_sendmsg(). These errors
> indicate that either the local port has been closed or the remote has
> gone down. Neither of these scenarios are fatal and will eventually be
> handled through packets that are later queued on the control port.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Sarannya Sasikumar <quic_sarannya@quicinc.com>
> ---
>  net/qrtr/ns.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index abb0c70..8234339 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -157,7 +157,7 @@ static int service_announce_del(struct sockaddr_qrtr *dest,
>  	msg.msg_namelen = sizeof(*dest);
>  
>  	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
> -	if (ret < 0)
> +	if (ret < 0 && ret != -ENODEV)
>  		pr_err("failed to announce del service\n");
>  
>  	return ret;

Hi,

The caller of service_announce_del() ignores it's return value.
So the only action on error is the pr_err() call above, and so
with this patch -ENODEV is indeed ignored.

However, I wonder if it would make things clearer to the reader (me?)
if the return type of service_announce_del was updated void. Because
as things stand -ENODEV may be returned, which implies something might
handle that, even though it doe not.

The above notwithstanding, this change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

