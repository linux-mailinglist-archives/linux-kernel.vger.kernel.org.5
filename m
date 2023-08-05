Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28178770D98
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjHEDsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHEDsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD113E;
        Fri,  4 Aug 2023 20:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD3662177;
        Sat,  5 Aug 2023 03:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E5EC433C7;
        Sat,  5 Aug 2023 03:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691207299;
        bh=QU/GmoLUQzSAZRjZezpkLQ4/uCOJLRiuDhLRFYj0Ibo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0pTknPQGzFlcF5NAMREDDzZnMjikzhGiKA1r7T3iRacWhwiKrqi3PKLKU6l4DTv1
         9BFVB/vcGEPVvYAUqUj9Zjie4EZo97sfvH8++fNTSBaztr+giTnDVPxHm50eNtPsjt
         3pwAO5IJm8exEd92XAPJqG5IB9nxB/QQn4yqU3GN5jMO84eHBNQdOIS+UQfD+AYqZI
         U1sr3kBm+BEEaklYbd3RArse+JlyrxT8xAIG0Mewid63g2aOhw2JJvM4J8cebPGcVH
         dKNBRWaysMbOdu7GO8PPGlTep4phaqvnjM3olEpT6j3UGwFzXkA8buyxWzdx9abZs1
         jnq21g7LuZy+w==
Date:   Fri, 4 Aug 2023 20:51:17 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 05/25] virt: gunyah: msgq: Add hypercalls to send and
 receive messages
Message-ID: <6uyzkx2cvfcz2vrosbj7crrzwo4emi2qitudnmzwh6t7fwqpez@lpg2yqkqgah5>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-6-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-6-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:33AM -0700, Elliot Berman wrote:
> Add hypercalls to send and receive messages on a Gunyah message queue.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  arch/arm64/gunyah/gunyah_hypercall.c | 31 ++++++++++++++++++++++++++++
>  include/linux/gunyah.h               |  6 ++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> index ef48e0b8b5448..c5bf0dd468ec9 100644
> --- a/arch/arm64/gunyah/gunyah_hypercall.c
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -35,6 +35,8 @@ EXPORT_SYMBOL_GPL(arch_is_gh_guest);
>  						   fn)
>  
>  #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
> +#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
> +#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
>  
>  /**
>   * gh_hypercall_hyp_identify() - Returns build information and feature flags
> @@ -54,5 +56,34 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
>  }
>  EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
>  
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, u64 tx_flags, bool *ready)

I find the name "ready" unclear, I believe it will be true to indicate
that the message queue is not full (i.e. Gunyah is ready to receive
another message?)

Naming it "full" and reversing the values would make this immediately
obvious.

> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_SEND, capid, size, (uintptr_t)buff, tx_flags, 0, &res);
> +
> +	if (res.a0 == GH_ERROR_OK)
> +		*ready = !!res.a1;
> +
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_send);
> +
> +enum gh_error gh_hypercall_msgq_recv(u64 capid, void *buff, size_t size, size_t *recv_size,
> +					bool *ready)

And this "ready" seems to be "more data available". Naming it "empty",
and reversing the values, would make this obvious.


Perhaps when working with the hypercalls on a regular basis it makes
sense to not invert the value space...renaming the two "ready" would be
beneficial regardless.

> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_RECV, capid, (uintptr_t)buff, size, 0, &res);
> +
> +	if (res.a0 == GH_ERROR_OK) {
> +		*recv_size = res.a1;
> +		*ready = !!res.a2;
> +	}
> +
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
> +
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 6b36cf4787efb..01a6f202d037e 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -111,4 +111,10 @@ static inline u16 gh_api_version(const struct gh_hypercall_hyp_identify_resp *gh
>  
>  void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
>  
> +#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)

Unless the flags are growing, passing this as a bool push instead of a
flag field seems reasonable.

> +
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, u64 tx_flags, bool *ready);
> +enum gh_error gh_hypercall_msgq_recv(u64 capid, void *buff, size_t size, size_t *recv_size,
> +					bool *ready);

Please wrap things to 80 characters, unless going a little bit over
makes things more readable.

Regards,
Bjorn
