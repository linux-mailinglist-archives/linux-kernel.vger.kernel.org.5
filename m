Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FFB7CB30E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjJPS4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPS4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:56:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3D95;
        Mon, 16 Oct 2023 11:56:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C1C433C8;
        Mon, 16 Oct 2023 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697482565;
        bh=QcyXCskRPbOnWPMhi0EFFGjPvt4mFSLqbM7WXj8RRTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uq+dK+u9sQe6i12LxkLFZefC/LT+F/9isgSSyVWofETmERrXFkhy+LsslGY1SPxQV
         aNRQG0xZYpZ5jC6v9GY7QL8u18a2CRGqIQeCyx/x5cfK82FJAT/K4vFTT6ykOqVrHj
         BTmOtqrkGGTIw/ICGxhPbbQEM0fD7lZJ1BBaGjpsN1bCnC5HQq6DbRLUtRo1ZYux0I
         ZFSJ69pSRxIexDVunyOx81Qn45YSlFJ25gPmSVu2bpvMCU7WOoKBI4Uv1sqWVE0zIL
         oicyw/lhvaWlRK9akRu/yLwe5GlYv1URMtVBfGARefOiL3KaPRvTHfWfUqsOBfK4bb
         JKL4Bgp1crJmg==
Date:   Mon, 16 Oct 2023 11:59:52 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] soc: qcom: apr: Add __counted_by for struct
 apr_rx_buf and use struct_size()
Message-ID: <arc5clw7z2avnt2tbw5mw6lvrj3kjebmuarju4uqc2hxtuv7ow@htiko7yh3oyf>
References: <ZSRw6RNi3Crhd32H@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRw6RNi3Crhd32H@work>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 03:30:17PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thanks.

> ---
>  drivers/soc/qcom/apr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index 30f81d6d9d9d..1f8b315576a4 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -41,7 +41,7 @@ struct packet_router {
>  struct apr_rx_buf {
>  	struct list_head node;
>  	int len;
> -	uint8_t buf[];
> +	uint8_t buf[] __counted_by(len);
>  };
>  
>  /**
> @@ -171,7 +171,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>  		return -EINVAL;
>  	}
>  
> -	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
> +	abuf = kzalloc(struct_size(abuf, buf, len), GFP_ATOMIC);
>  	if (!abuf)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 
