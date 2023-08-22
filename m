Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7088784598
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbjHVPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjHVPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86091CE9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692718266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqLO2V0ZPwoCiwmUHn1tH4GQt5T66HZTGlrG692z+68=;
        b=CsYnvAotBGwAq4d+OsW9ZNCQhC2EqNRKNfYqJofLdcUPa9j0a572E8TQU/xT35vAsX3Kdv
        9ixgh2YRKqqH7W7FoDbmjV3NheAFffOoTlMa9/k0B3PuslIA6OOJOSxbTHPsNaRadr+mNe
        rqKSBecuQipNUEGGp3XxXPVCgXH95uU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-NcqLKGp1NjeZRtajKUzuHQ-1; Tue, 22 Aug 2023 11:31:05 -0400
X-MC-Unique: NcqLKGp1NjeZRtajKUzuHQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99e168f4f38so57778666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718263; x=1693323063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqLO2V0ZPwoCiwmUHn1tH4GQt5T66HZTGlrG692z+68=;
        b=IW+on9Tuoy1kUHYSQEDbg1hkJtWoRXPEYEXgJNvz5vDT8y15apBKh1rZF0eTMipiRj
         DTd+M6i4cKEyR8qUNKprTFQw+VXaf32A/X0fV72vdKN1qJJCDsA9kLOy35rAHL1BUsKg
         Br5TXX8WTK/e7GdHkG+qBY2RfH1DKUKEc21wnMldFT29LyhZXWF98NJZNjqTtGQ9eZWN
         rFV3I6E52ju6vQqdbl4eB+/tDqmUUtLU42+WdjfbiZJxjCTY0o1iNg+Sr93gppKTsG3V
         e5vbaJrdnroZNCLE023/8CNKXoPrbvjL7BUUYBXHRyA20x80usycD9aJ2od91flJYYL+
         y3kg==
X-Gm-Message-State: AOJu0Yz2lP5mbTAM9sjp8bdEQh0zMDATp8DxrV6VdXIwi6T8vmA598t0
        HXAjp1blahsNfu3Wudk/hZmii1Jos4vqBMYBkNPqRyLqG5OEd1oMucCzEuPV6+vzrXy/lryYm+Z
        NqaaLaffG8JJU8AbgBrX3XVsL
X-Received: by 2002:a17:906:51ce:b0:9a1:b4f9:b1db with SMTP id v14-20020a17090651ce00b009a1b4f9b1dbmr1930715ejk.1.1692718263253;
        Tue, 22 Aug 2023 08:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qLldO9SHriB/biC2xhIUus+4dimS51pERtZRGR9Vw2TOIqYiK47v/foUI/IPbMNkxI46ig==
X-Received: by 2002:a17:906:51ce:b0:9a1:b4f9:b1db with SMTP id v14-20020a17090651ce00b009a1b4f9b1dbmr1930697ejk.1.1692718262982;
        Tue, 22 Aug 2023 08:31:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b0099cf840527csm8299419ejm.153.2023.08.22.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:31:02 -0700 (PDT)
Message-ID: <f80fcd476a230c354bf9758762250c43a1f3d5cc.camel@redhat.com>
Subject: Re: [PATCH] sock: Fix sk_sleep return invalid pointer
From:   Paolo Abeni <pabeni@redhat.com>
To:     eadavis@sina.com,
        syzbot+666c97e4686410e79649@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ralf@linux-mips.org,
        syzkaller-bugs@googlegroups.com, hdanton@sina.com
Date:   Tue, 22 Aug 2023 17:31:00 +0200
In-Reply-To: <20230822124419.1838055-1-eadavis@sina.com>
References: <000000000000e6c05806033522d3@google.com>
         <20230822124419.1838055-1-eadavis@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-22 at 20:44 +0800, eadavis@sina.com wrote:
> From: Edward AD <eadavis@sina.com>
>=20
> The parameter sk_sleep(sk) passed in when calling prepare_to_wait may=20
> return an invalid pointer due to nr-release reclaiming the sock.
> Here, schedule_timeout_interruptible is used to replace the combination=
=20
> of 'prepare_to_wait, schedule, finish_wait' to solve the problem.
>=20
> Reported-and-tested-by: syzbot+666c97e4686410e79649@syzkaller.appspotmail=
.com
> Signed-off-by: Edward AD <eadavis@sina.com>

This looks wrong. No syscall should race with sock_release(). It looks
like you are papering over the real issue.

As the reproducer shows a disconnect on an connected socket, I'm wild
guessing something alike 4faeee0cf8a5d88d63cdbc3bab124fb0e6aed08c
should be more appropriate.

Cheers,

Paolo

