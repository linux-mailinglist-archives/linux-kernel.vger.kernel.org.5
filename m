Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4AD7B0D51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjI0UZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjI0UZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C02C114
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695846291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hz4HjlvMoyMlJFk+Px6NXXwtj0eY3c4mO7NnPf9aXgU=;
        b=Rf3OdmVH0F0pzrMSR+UHjxipJGzWs/MHm/Y5es1nuQpbP8/zmOBqWEr+QR2Yo/yMVL3H9e
        dBIZ9MSmQbnffJHVTIHQy8Nt4jrXPzbkqow2s1FofnnF0aWJYW8i1b0G7oueJS7N9Jkp8A
        OMe+E6vn2i0yKIEogWO940a4VqEFIoU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-0xuIEUIYPXK84wg5g2ygQA-1; Wed, 27 Sep 2023 16:24:47 -0400
X-MC-Unique: 0xuIEUIYPXK84wg5g2ygQA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E19F93C0DDA2;
        Wed, 27 Sep 2023 20:24:46 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.10.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F2E1492B16;
        Wed, 27 Sep 2023 20:24:46 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v2] openvswitch: reduce stack usage
 in do_execute_actions
References: <20230921194314.1976605-1-i.maximets@ovn.org>
Date:   Wed, 27 Sep 2023 16:24:45 -0400
In-Reply-To: <20230921194314.1976605-1-i.maximets@ovn.org> (Ilya Maximets's
        message of "Thu, 21 Sep 2023 21:42:35 +0200")
Message-ID: <f7t34yzpdo2.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilya Maximets <i.maximets@ovn.org> writes:

> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
>
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
>
>      a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp
>
> NSH is not a very common protocol, but the space is allocated on every
> recursive call or re-entry multiplying the wasted stack space.
>
> Move the stack allocation to push_nsh() function that is only used
> if NSH actions are actually present.  push_nsh() is also a simple
> function without a possibility for re-entry, so the stack is returned
> right away.
>
> With this change the preallocated space is reduced by 256 B per call:
>
>      b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Thanks, Ilya.

Reviewed-by: Aaron Conole <aconole@redhat.com>

