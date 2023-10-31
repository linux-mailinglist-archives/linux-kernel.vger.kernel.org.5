Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570927DC947
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbjJaJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjJaJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9FC2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698743913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bx3whZQGfbNRV1288q3CSKQ568eW0DOq5hrYpiuzhzo=;
        b=VtXOzRYj4y+Np4wokbPt565MpW3KA0Ix7KXL3axNbO/DWua5fOTK7uRovOi9s//djEow1l
        aZ1bbr407KUmaJoZ76N+dGdbomEhXeaMtHo34Fa+rcW+lc3wrRD/HhZ8CZXHL/BjBqKXf0
        RWRLntdQU6fwLZ3DXY+ahtjQuOpw9RA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-j7yu-9hyM4Cou4v_vLmaqA-1; Tue, 31 Oct 2023 05:18:32 -0400
X-MC-Unique: j7yu-9hyM4Cou4v_vLmaqA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50798dd775dso1378308e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698743910; x=1699348710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx3whZQGfbNRV1288q3CSKQ568eW0DOq5hrYpiuzhzo=;
        b=qa7LmGzaW+6gcTX0fQOXhqA/MS4FLTL41phdvlqe/wX7jUbCWzErbPTsvG8OspzsVp
         YNpy/pTBDQRJvBTqo8GSodQ4E/1jx7jC78s7g5r2iA2H2UcjSW04Czje7gcMQbuvhIBi
         ZgEHCZJGEfVyGBBGTIos3dDqtAGfzWvQdthFp+YfP5Q+BBw8HCHa7LvihDTFSrVHSnEf
         OUlQmVSWQY1gCkgY0oAut5gmUBg51PpT30VHhsNHkTIHTne++XwJt7ZXavQL6ZJ1VNJj
         vShx66SwCYox3dUCugz7MPOQzu4sGGYDy4ZiUNbXET3/ckwVw67T8XeOiAuBJVu/M1GM
         HHYQ==
X-Gm-Message-State: AOJu0Yy6hTTpC9ma/qWol1FW3sYzcvDDgx4WHuPU+yPeilrI2jkHPX1L
        4HtgSEmdxJrdOEeue58A+Gd4gUFvbIXE9Lojqv2+A8qm3IaFCCrT9FFO9aGC515Fyx+4VDK8fn2
        HU58iXDsDiQo9pqEhbtC9IlTgCCKL4Fjg
X-Received: by 2002:a05:6512:2348:b0:507:b1b8:cf0a with SMTP id p8-20020a056512234800b00507b1b8cf0amr9918148lfu.3.1698743910437;
        Tue, 31 Oct 2023 02:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5YLpjsXMB2fxpnL44Wu1EYPRjkWRAyiAWVaBJOAR4pKlok5TbBpG/GFH/KhWPx8rjL/B3w==
X-Received: by 2002:a05:6512:2348:b0:507:b1b8:cf0a with SMTP id p8-20020a056512234800b00507b1b8cf0amr9918124lfu.3.1698743910073;
        Tue, 31 Oct 2023 02:18:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600c2e4200b004064e3b94afsm1160179wmf.4.2023.10.31.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:18:29 -0700 (PDT)
Message-ID: <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lucas Karpinski <lkarpins@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Oct 2023 10:18:28 +0100
In-Reply-To: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-30 at 13:40 -0400, Lucas Karpinski wrote:
> The sockets used by udpgso_bench_tx aren't always ready when
> udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
> kernels, but can occur in both. Replace the hacky sleep calls with a
> function that checks whether the ports in the namespace are ready for
> use.
>=20
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
> https://lore.kernel.org/all/t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzr=
zkwtj@toz6mr4ggnyp/
>=20
> Changelog v2:=20
> - applied synchronization method suggested by Pablo
> - changed commit message to code=20
>=20
>  tools/testing/selftests/net/udpgro.sh         | 27 ++++++++++++++-----
>  tools/testing/selftests/net/udpgro_bench.sh   | 19 +++++++++++--
>  tools/testing/selftests/net/udpgro_frglist.sh | 19 +++++++++++--
>  3 files changed, 54 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selfte=
sts/net/udpgro.sh
> index 0c743752669a..04792a315729 100755
> --- a/tools/testing/selftests/net/udpgro.sh
> +++ b/tools/testing/selftests/net/udpgro.sh
> @@ -24,6 +24,22 @@ cleanup() {
>  }
>  trap cleanup EXIT
> =20
> +wait_local_port_listen()
> +{
> +	local port=3D"${1}"
> +
> +	local port_hex
> +	port_hex=3D"$(printf "%04X" "${port}")"
> +
> +	local i

Minor nit: I think the code would be more readable, if you will group
the variable together:

	local port=3D"${1}"
	local port_hex
	local i

	port_hex=3D"$(printf "%04X" "${port}")"
	# ...

> +	for i in $(seq 10); do
> +		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
> +			awk "BEGIN {rc=3D1} {if (\$2 ~ /:${port_hex}\$/) {rc=3D0; exit}} END =
{exit rc}" &&
> +			break
> +		sleep 0.1
> +	done
> +}

Since you wrote the same function verbatim in 3 different files, I
think it would be better place it in separate, new, net_helper.sh file
and include such file from the various callers. Possibly additionally
rename the function as wait_local_udp_port_listen.

Thanks!

Paolo

