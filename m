Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2C7DF103
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbjKBLPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjKBLPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327F187
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698923698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5X9zXTo8eLbZpNfNphwqZUMseNZ35B8f3qHoWgzx6M0=;
        b=UyRQN0WYcFSZz4Dn8thqtY2nYcsdFEHEO2KsSUU928Svs0IA2cXzLRNAq0LboOcLTAXviP
        UNFYGa3KMwpLMP7JviHXnc5bgcljhLYRvNhuyXuyeNY73NPBDErXhL+/o05fWC1emUoH8s
        iHtdMd5DcuDtLGHprPr3mnmSm+Gbb3U=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-2GUG9ZsQMQ-y97uMqEqVEQ-1; Thu, 02 Nov 2023 07:14:57 -0400
X-MC-Unique: 2GUG9ZsQMQ-y97uMqEqVEQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c3e3672dc8so1137681fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698923695; x=1699528495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5X9zXTo8eLbZpNfNphwqZUMseNZ35B8f3qHoWgzx6M0=;
        b=MVJ8fwDJd+JmoWerFLvn/8vrnXwJL8XG0SYNgB1jEEliuBV0jhfGGEGcfxx3Sxxmpa
         0LDrxrcjJiZDa1QhfKIZwSnYIsj+5OPeSPRhEFVjBIdRNeGAWpTOnv4f5PlSv50YBHTS
         Qzcl+vaH6iXZpz5cTPrzAKjyx8Jd0g7hf8FHHWrwN7RMjFF/CJBgVglIdsWi9YWW9Ovr
         nzfI42sghBfgUgNviIlfxZH3e/E7h9K0oCkMhVsauLZd/IGnjiCOohw6RL93B4f/eCbs
         qSxTyRoJ5YjbYAczNyMbekfS+EcPYQzeWJvFTV6NqVAEmKIKhwbM04xrjLCn5faA1s1p
         ruYA==
X-Gm-Message-State: AOJu0YwsEOQpLHm14lVVODZBI1CULH55T0TWYHIO0PEiliFTP7d7kUg0
        p/PPvaObadDuhaRqHE/Tt9ZtM2kIhFjO4FUqKq7kM+10VDEZbniewjw4yyBXQ0IF0DtpCAEP9nr
        CNZKGo1iispNpUvSFUBm/BcMj
X-Received: by 2002:a2e:3306:0:b0:2c5:519:bb1b with SMTP id d6-20020a2e3306000000b002c50519bb1bmr12741484ljc.2.1698923695607;
        Thu, 02 Nov 2023 04:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIpcoz45TDqA5S9HUXzHFHPPonuHMZEBqFML5f/SHsIM081u0+qPTrXpL9C2SsQVtX6luAMw==
X-Received: by 2002:a2e:3306:0:b0:2c5:519:bb1b with SMTP id d6-20020a2e3306000000b002c50519bb1bmr12741468ljc.2.1698923695235;
        Thu, 02 Nov 2023 04:14:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c1c9000b003fee567235bsm2654539wms.1.2023.11.02.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:14:54 -0700 (PDT)
Message-ID: <f41c06eafd983584647e7d61561ea6282cdb735e.camel@redhat.com>
Subject: Re: [PATCH net] dccp: check for ccid in ccid_hc_tx_send_packet
From:   Paolo Abeni <pabeni@redhat.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Date:   Thu, 02 Nov 2023 12:14:53 +0100
In-Reply-To: <20231028144136.3462-1-bragathemanick0908@gmail.com>
References: <20231028144136.3462-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-10-28 at 20:11 +0530, Bragatheswaran Manickavel wrote:
> ccid_hc_tx_send_packet might be called with a NULL ccid pointer
> leading to a NULL pointer dereference

You should describe how such event could happen.

> Below mentioned commit has similarly changes
> commit 276bdb82dedb ("dccp: check ccid before dereferencing")
>=20
> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc71bc336c5061153b502

and add a suitable fixes here.

(beyond taking care of other critical code paths, as reported by Eric).

Thanks!

Paolo

