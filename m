Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7A7A25CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjIOSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjIOSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:31:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCD1FD6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:31:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502fdfeb1d9so154931e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694802666; x=1695407466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FGZ9ZTnOu7596w3VvjV0x5HW3z9D+rx5VrD56yVVgU=;
        b=aXw//4+9oF8EQcjLHPThE3nWWRq0C7eEiRU/DzvyU7twiCNtB9DQXF/kqBJwv5SOLG
         SwXRqVrh19Yah6Scobhn/qaYR7e19G4IOoBW2ax4Mo7B7OjdCzfOOfoMGzcb8Z3Zy0zX
         LCWI1RQKCoTbDilOCYA8Lb6uK8CS21Ou/+vPSC0/DCejWEN9x5Yple3ZbCgUE+wTClup
         aBrU74fb833yN2tve8mpvTP4RvhN8RpCHaGpRbfb5KkQNzNoTPXpDFCSwWuDfBVA8hr5
         8IJmr1zLK1PppItGcKmsSTVTKeJGVpRzC2Gv6zbrn+vrJwj7QyTIKCGQ9tj6kDG+4Q/i
         rD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802666; x=1695407466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FGZ9ZTnOu7596w3VvjV0x5HW3z9D+rx5VrD56yVVgU=;
        b=HKWVyosb7uGXvKTis+iV4gjnFGgqhkjFWYuzSr+fnaL8MMXC2FisbNTxb1yLOcPv/s
         NMV9DI8XWURSKINS+L1ux3T927X96wOydmulkhV1M7RzaetLdkKBXPq/w2ZZnxYuIi+n
         2AXp2UEv2mlZP72CTVh2VtycDyjjut38Y8pNqaKARLNxTQlhj86LWsb9RcJ6fW49R1GK
         U4aJRB3pvA6X8quyd32OdLAdHJRI5Feux8rtCb2iQpov0Rs6Q108MN9nwfWBZ34JTxPF
         cKdsW85XOp1FzxCiagjQ1YSaXLllxr++TfK8nFLgp/uVUkR6Lb6C05vUYnmLGtbi90oa
         CcmQ==
X-Gm-Message-State: AOJu0YyHdk+U6UswjCfejonAIX0XDnnzqFEuSAw/8kKVr+SIkz7GCUzV
        gv3WQBjXWOpuXfM4tWKm0SI=
X-Google-Smtp-Source: AGHT+IF4NSDGWtDlRAnqykE8mLXyKiDsQIKggA6DnGziX0rm6g5zAN1g8v8pPhHUXd27SGxWATPTaQ==
X-Received: by 2002:ac2:499c:0:b0:500:9d32:8deb with SMTP id f28-20020ac2499c000000b005009d328debmr1883797lfl.51.1694802666052;
        Fri, 15 Sep 2023 11:31:06 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c5-20020a197605000000b004edc72be17csm717494lff.2.2023.09.15.11.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:31:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 15 Sep 2023 20:31:03 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 9/9] mm: vmalloc: Set nr_nodes/node_size based on
 CPU-cores
Message-ID: <ZQSi58fnZyavioh2@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-10-urezki@gmail.com>
 <ZQRWIRzhspyU1xIE@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQRWIRzhspyU1xIE@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:03:29PM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> ......
> > real    1m28.382s
> > user    0m0.014s
> > sys     0m0.026s
> > urezki@pc638:~$
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> 
> LGTM,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Applied. Thank you!

--
Uladzislau Rezki
