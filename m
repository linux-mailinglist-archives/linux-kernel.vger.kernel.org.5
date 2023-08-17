Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E476377FC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353718AbjHQQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353788AbjHQQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A48B2724;
        Thu, 17 Aug 2023 09:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4D6611D1;
        Thu, 17 Aug 2023 16:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08104C433C7;
        Thu, 17 Aug 2023 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692290730;
        bh=T7CaczE4fx99yNyJb7K4H+68w6ueE9VHwt80AuJDPqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NiEcBN6cBpuPy14fX1WNxXOlf9NtLUERSPibnl4UqT0xxV86a2YxuX5GdnxyDaG0b
         nD5h26huuie9ahpT6IFsMnIa5pl1lvLY4E2KyIFtk6ncopIoLyTRGTGUTb2LN7qIQD
         bMAMII4fpJaqUXFxzg8co3GmT0DuCf2gdqcpd/HlatFePrRBp0JMmqRyPxdfU7iN0r
         Y+/EMRi4mtMVUEtWDGTISY1hkQmib2PvAhCeeEvMLaRPrlPcx7u/9rS4343IR1Khe1
         NTJKBCbOUgIz/ol/aymtqgu/kbw8PQeGiFdBjX2J7SbaiCn0Wkg237RFG3ZBfvuxcR
         3S9KaRQFXtYMQ==
Date:   Thu, 17 Aug 2023 09:45:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] can: netlink: support setting hardware filters
Message-ID: <20230817094529.68ae1083@kernel.org>
In-Reply-To: <20230817101014.3484715-2-martin@geanix.com>
References: <20230817101014.3484715-1-martin@geanix.com>
        <20230817101014.3484715-2-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 12:10:13 +0200 Martin Hundeb=C3=B8ll wrote:
> +		int len =3D nla_len(data[IFLA_CAN_HW_FILTER]);
> +		int num_filter =3D len / sizeof(struct can_filter);
> +		struct can_filter *filter =3D nla_data(data[IFLA_CAN_HW_FILTER]);

This will prevent you from ever extending struct can_filter in=20
a backward-compatible fashion, right? I obviously know very little
about CAN but are you confident a more bespoke API to manipulate
filters individually and allow extensibility is not warranted?
