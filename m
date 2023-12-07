Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB18090FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443450AbjLGTCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjLGTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:02:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B6171A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:02:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B60C433C8;
        Thu,  7 Dec 2023 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701975757;
        bh=Lp4XJ1aqwUEf86+3xhp9+XdmCpF1YtsDAR77+7S8C10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ll0TFuur7xZX3Jve0cKmqyLBvYhGcwQteAtzj617bQsTT6j/C2VqH0dlyYJIIBHXM
         w+NUQszJRHPzIyAMMEnLRIi/Px9joMoIigtyY5eKzBAcver2lgzduAd9nJGIHiln/8
         447val4HGq706N32t+0SZpopA7ZOz/7TBE6gTQhQU2jTjqn6fQ0NizCLQ/44KjVRBx
         6rNu6qaI7KuN0ZvgIJ/UZWeBiNj85cHJWDAPGzvlEe2dhd59iFg9TxsQq5FiMQytA/
         lKwSWc8z0L1g3Icj8bbyofkyVGBCLIAaB1Nkq10wtJNNlcpF/1QwIgQDczwOs3u/KA
         +BVmRodNhhaLw==
Date:   Thu, 7 Dec 2023 11:02:36 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Aron Silverton <aron.silverton@oracle.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZXIWzBxR3S39Snn3@x130>
References: <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
 <20231207092329.3ec04dca@kernel.org>
 <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Dec 12:06, Aron Silverton wrote:
>On Thu, Dec 07, 2023 at 09:23:29AM -0800, Jakub Kicinski wrote:
>> On Thu, 7 Dec 2023 10:41:25 -0600 Aron Silverton wrote:
>> > > I understand that having everything packaged and shipped together makes
>> > > life easier.
>> >
>> > I think it is a requirement. We operate with Secure Boot. The kernel is
>> > locked down. We don't have debugfs access, even if it were sufficient,
>> > and we cannot compile and load modules. Even without Secure Boot, there
>> > may not be a build environment available.
>>
>> This 'no debugfs' requirement is a kernel lockdown thing, I presume?
>> Are we expected to throw debugfs out the window and for all vendors
>> to reimplement their debug functionality via a misc driver taking
>> arbitrary ioctls? Not only does that sound like a complete waste of
>> time and going backward in terms of quality of the interfaces, needing
>> custom vendor tools etc. etc., but also you go from (hopefully somewhat)
>> upstream reviewed debugfs interface to an interface where the only
>> security assurance is vendor telling you "trust me, it's all good".
>
>IIRC, with lockdown, we can read from debugfs IFF the entries'
>permissions are 0400. We cannot write. It's not suitable for
>implementing an interactive debug interface.

I would like to add that debugfs is usually used to expose the driver
software states, as it evolves and changes with the driver code, but as I
explained in the other email, it's clearly not a good solution to expose
arbitrary objects of complex devices, that require interactive and
selective debug interfaces tailored to the user use-case.

