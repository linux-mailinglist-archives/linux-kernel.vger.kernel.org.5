Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961FA77BF95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjHNSNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjHNSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9510F7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692036726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+yOj+yKntgsG0drgyyHIA7iDO2ZYuAK+/lXEF9ROjw=;
        b=iMkqV37Re1CMoUhJl/em7WaeSOUwTM3U+W31a4xT9FvFABvnNDKDEzkgyugXHw0/X6oqCt
        4yp0eR2OdP2y/z5JmGNoRZuGHWSRNd2pKOqNOr95Stmk7Ha0Z4oAA8G/eOZokyLwV8fqn5
        hs+G1k3VF1Lx7TO0r4ZLTwV1TOoG3Kk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-_al0oEUfMy2UoQY_hzhk1g-1; Mon, 14 Aug 2023 14:12:01 -0400
X-MC-Unique: _al0oEUfMy2UoQY_hzhk1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6FE21C03D86;
        Mon, 14 Aug 2023 18:12:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 53E3040C2063;
        Mon, 14 Aug 2023 18:11:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Aug 2023 20:11:18 +0200 (CEST)
Date:   Mon, 14 Aug 2023 20:11:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com, david@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        dave@stgolabs.net
Subject: Re: [PATCH v2] kernel/fork: stop playing lockless games for exe_file
 replacement
Message-ID: <20230814181114.GD17738@redhat.com>
References: <20230814172140.1777161-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814172140.1777161-1-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, Mateusz Guzik wrote:
>
> However, fe69d560b5bd ("kernel/fork: always deny write access to current
> MM exe_file") added a semaphore up/down cycle to synchronize the state
> of exe_file against fork, defeating the point of the original change.

Agreed,

> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/exec.c     |  4 ++--
>  kernel/fork.c | 22 +++++++++-------------
>  2 files changed, 11 insertions(+), 15 deletions(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>

