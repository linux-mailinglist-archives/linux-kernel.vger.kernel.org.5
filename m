Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4743D7C4706
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbjJKBIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKBIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:08:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098E8F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:08:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA7C433C8;
        Wed, 11 Oct 2023 01:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696986520;
        bh=q6kCuKw1p9zMOPVBO4PESzKHHtd8rxfLWiEaydvuP8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1oKeHYLIwOvj57maEkeiU/sXMyjNjKzGbBivTqn4jMWhhrkRgl1WQseQhT+j7T1J
         p1bQTwIR7EObse0T5HRmZCu7IRKc/8TRGWMZgFYVeOxyFsfLv0nNpNgl0kjL3h2Q4B
         CF2/Z8D8SFqAkRWT1dPQ5z3yptR2sjXGrqMLr5XasZQvfgGCKdgKa1/cmXKpvMenO9
         y3tqU+lDsjTfxLgmxnplB3hrrNnZ5dkVKrcQTE/95DYEsE5yG4502IMg6gf7s0Z1YA
         PpX04tiF6vebL7346+zM9Zut/sqGj3Zy0M5kksvXP+WYxtTzmORvMsJ4ElYY/VmbmF
         UFPC5+0MCdDwg==
Date:   Tue, 10 Oct 2023 18:08:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>
Cc:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec
 for mptcp
Message-ID: <20231010180839.0617d61d@kernel.org>
In-Reply-To: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
        <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 21:21:44 +0200 Matthieu Baerts wrote:
> +definitions:
> +  -
> +    type: enum
> +    name: event-type
> +    enum-name: mptcp_event_type
> +    name-prefix: mptcp_event_

I think you can use - instead of _ here.
For consistency with other families?

> +    entries:
> +     -
> +      name: unspec
> +      value: 0

90% sure enums still start at 0, only attrs and msgs now default to 1.

> +     -
> +      name: announced
> +      value: 6
> +      doc:
> +        token, rem_id, family, daddr4 | daddr6 [, dport]
> +        A new address has been announced by the peer.
> +     -
> +      name: removed
> +      value: 7

Follows 6 so no need for value?

> +      doc:
> +        token, rem_id
> +        An address has been lost by the peer.
> +     -
> +      name: sub_established

Similarly for names we generally recommend - as a separator.
Looks more natural in places where it's used as a string, eg Python.
Well, I guess at least to me it does :)

> +      value: 10
> +      doc:
> +        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
> +        dport, backup, if_idx [, error]
> +        A new subflow has been established. 'error' should not be set.
> +     -
> +      name: sub_closed
> +      value: 11

and here, /value/d, s/_/-/

> +      doc:
> +        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
> +        dport, backup, if_idx [, error]
> +        A subflow has been closed. An error (copy of sk_err) could be set if an
> +        error has been detected for this subflow.

> +attribute-sets:
> +  -
> +    name: address
> +    name-prefix: mptcp_pm_addr_attr_
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: family
> +        type: u16
> +      -
> +        name: id
> +        type: u8
> +      -
> +        name: addr4
> +        type: u32
> +        byte-order: big-endian
> +      -
> +        name: addr6
> +        type: binary
> +        checks:
> +          min-len: 16

Do you not want the exact length for this?
If YNL doesn't support something just LMK, we add stuff as needed..
