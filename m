Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C117925FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjIEQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353744AbjIEHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:51:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C135BCCF;
        Tue,  5 Sep 2023 00:50:57 -0700 (PDT)
Date:   Tue, 5 Sep 2023 09:50:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693900254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MutGdXNEcm5iJDpAgKUMr2fqtKokWlFeWhM1/hK0FPk=;
        b=MQPZHtcpYu7nAzsnmZmdKdnVT5XJx3bG34npCaLOERPJMBpMaYb0/WJUbYh5c7VMTPcZVs
        oJ453im8jU5ntjMHcDLxMqlab8bot5lKodlOFRhph5AE3SFMG+EKoWmBDHF/miSEAOf2ai
        fW/5K6Lv0nrSTrFBO11/FsqtfM1qKYmhDAJelhP+d7vAEjMIoJu0cVYJA9AWqFDUQVdP3/
        6w4HlEgcfJVjB3LupiebrRdhUO7fLjZJakVlrg7vs7sR9cCifbCjFBt46tPq51bWnmsHKQ
        EsL9rIr4PgUtmav6z0xRwLT0UBrAJM0pQolK/KJTFG9vAinWyUaNm6rBw4+Sgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693900254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MutGdXNEcm5iJDpAgKUMr2fqtKokWlFeWhM1/hK0FPk=;
        b=YJbuJ0Rz5XvuEK5doHmJd2yNtdE/eAPnbSibnL87Gv9f6dL1r0+cn9CTuv+8ywiPNDYFRh
        CefZku2HOhzscQAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
        linyunsheng@huawei.com
Subject: Re: [PATCH net] octeontx2-pf: Fix page pool cache index corruption.
Message-ID: <20230905075052.KwIVTze9@linutronix.de>
References: <20230904144304.3280804-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230904144304.3280804-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-04 20:13:04 [+0530], Ratheesh Kannoth wrote:
=E2=80=A6
>=20
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index e369baf11530..cf2e631af58b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -561,10 +566,18 @@ int otx2_napi_handler(struct napi_struct *napi, int=
 budget)
>  				otx2_config_irq_coalescing(pfvf, i);
>  		}
> =20
> -		/* Re-enable interrupts */
> -		otx2_write64(pfvf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
> -			     BIT_ULL(0));
> +		/* Schedule NAPI again to refill rx buffers */
> +		if (unlikely(!filled_cnt)) {
> +			udelay(1000);

A delay of 1ms? Short term I would suggest to set up a timer for polling
this case instead of delay. On a UP you wouldn't make progress that way.

Long term it might make sense to allocate new page/ memory before
handing the current page/skb over to the stack. Should allocation fail
then you have at least one slot (your current one) which can ensure that
you can receive on further packet (which you either drop on the floor or
pass to the stack).

> +			napi_schedule(napi);
> +		} else {
> +			/* Re-enable interrupts */
> +			otx2_write64(pfvf,
> +				     NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
> +				     BIT_ULL(0));
> +		}
>  	}
> +
>  	return workdone;
>  }

Sebastian
