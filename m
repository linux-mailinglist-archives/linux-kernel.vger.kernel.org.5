Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD997F8B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjKYNUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYNUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:20:48 -0500
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B6BB7;
        Sat, 25 Nov 2023 05:20:54 -0800 (PST)
Message-ID: <ca35ceb2fd2ddb6f0957d9b0a3725683@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1700918452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yiC4UUs8USPKG2VyFXfOJHX6dwMMN34F6Chb61Y8huk=;
        b=Iy/gHYGzrSQbrgqaAGfneakqafvv4c4NWn3KZ3aIIUGgPP2NGRUOn0WncdytlVxFIiMJpF
        DfAij8EhWTY77JY3pkA40hhQzVbRPuWzihiHlac3TzzMn4HPrGoWOZJrPn5T2T18bIlO1R
        w0Z1hcj9X0Z/V7tDiabXkLWAgU38nzk5LcVBjXo/dOylDrka6xu0RA4Rbx2i0pGae9Pt28
        DLqyYLv4C7ivGPMKZsO3TJttD4E3U544mV3q/+4kyefDvxBVG+IbGYNmgLG44KIkc7Ybr+
        rFOImeskH9J/uyjAmR6TTo/LxkmXyNF1X6xhw3Oi1LCE5X+OUjCHWYbfcxU1fQ==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1700918452; a=rsa-sha256;
        cv=none;
        b=LIWz/5wzrSO7VTpVeN59TZZX9dUqj4dmkYTyI8AqTyjpjI1MeJsO+SIGurVIjvOj/KJc/j
        lFsUH++sSjii1vg2G8Luhl8u4NXgM/Tgt1BAwM0pOU5FDSJ/wibaqcpQdTTz3urNc0KN+A
        C9w3T22Ta5nJ/NbRyFl/p+jPG2vAM3KbJu2vLYK/HdAAmURZyCBkcHtea9aosOVma0otXc
        lsfpD7401zQ+DynGitscjS7cD8w0yiS55M/twrbjScCD2sC9K7YPZKVt/h1QMdR2aFnjt4
        sij+p71Dl1b910MPEe9pqlZF576h1yXZK4kr/r2RaqrDeZ0mpgbjrI8yuFLv1g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1700918452; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiC4UUs8USPKG2VyFXfOJHX6dwMMN34F6Chb61Y8huk=;
        b=swmjcoNx1wntVwPGhY2F0p2pQjpMlYkFezHWbjWvX5xYsuqz5zV8d6f0g0iztThmjMXVFf
        OtqmT1G57NiwUs5ca+y1sasSced8kkcdhXFO6v2/KKaP5MRKYcFzss3TwsnFOIt1+PCpeM
        /K8M9d/ZEfpkM326Y9L2xDD3m4SKpn0CI93MC22jvmQAQe5GfL8PonL+p1CanjpSQRWxE9
        ZsRZBrzP58CU+5/dsSt5a3DOHyAtYjf02OpUBmi+aoZIATdOhPdxRIUIdQrQOSRPYF1RMB
        wNke4TLGwGjO8xh+DGHkyfqnqzEV3JdVS1wIp51rJNC80uxns/RFSNgnFzXlSw==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Steve French <smfrench@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Set the file size after doing copychunk_range
In-Reply-To: <CAH2r5muRJqefiMiJwKdUJZp4HMprJYCCRNSzMysCUizikQC+UA@mail.gmail.com>
References: <1297339.1700862676@warthog.procyon.org.uk>
 <1335877.1700868425@warthog.procyon.org.uk>
 <CAH2r5muRJqefiMiJwKdUJZp4HMprJYCCRNSzMysCUizikQC+UA@mail.gmail.com>
Date:   Sat, 25 Nov 2023 10:20:48 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
