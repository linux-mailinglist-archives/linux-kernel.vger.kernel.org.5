Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E761A7AFA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjI0Fy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjI0Fyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:54:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754165BA;
        Tue, 26 Sep 2023 19:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9ajPAdyvyfvBSng81G0aMNqDplRTRYNlUCGoxOBAZCHIR8IlBZ8XZyI9/oMYl6bUoS3Ire24JeOweKxj2kQ3f6C68L8kg1GyG4rcWuPHF5A1IaRGiLQSzPU2Z56o9t8WefUbefl8GFJk4E1HHBwwUilCwpkbJTILkjmrlKvGPEUp2vK8hN86ucFjmtrmVTK5dQ04wDhmVV/j9knr6GOq395kmr9Kx6fAcT7dt8fxK+yeKMR0u8jrmQ0My8dgD+GGTBJ7Otq7c4nrsfRnMQ/Vo5tSVI5joCyNtg5a+ELSGYMl1KVI+BTKqnkyKg49NfV7scqBN0jbFF/eYyZBM3w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3pEpolyj5nY1tLisFCwcfD5NoQpr2b/Reun4Z1M8SU=;
 b=WAM3yk5ozzbrISSQcklFwVEqRdEofSf7Z8gI/ap13CQYmbwti5YQ4w6PkJU0usCTikDXU/0WsMrOqEGph9S+m8wzKvZCZ8pp5uJSGTaiOzTITX6v/4LB1Z2K5GLcexfRAXOYTOupgZYZbJm8zSscb8Uw8uz2/EGoXsheY1YVWe5+jhJLxbgx2Pu7ovC+djuJISKionsJQVaTuU+uGAYz7K4yDy+guYMxKMF1difJK6gyrVy3NKZ//AK0xKVuEHTHvtspL2fCww8A7K9GRvngCM8EwEJqx3F2K4RFodr2ErBDWKb+39hMG1X9YaMWwBgZ+/NpWlyWFWAaMLrmqKS75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3pEpolyj5nY1tLisFCwcfD5NoQpr2b/Reun4Z1M8SU=;
 b=olVjtQ0X2fzCb2Kqdb+czx1V6IZ5NF6+mLd6pu0zftuJVYomx5ucNEy6fr/YShpkp1RfwLVojli7Lvgety4/1Hu8xPYuTBdPkDQH3Mc0q0VTevSO7SjlmNYLKTLMQesTI23vFzh4iE9VyLS//dyzt/flvtkhnCSgLrUdar/PNvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DS0PR08MB8489.namprd08.prod.outlook.com
 (2603:10b6:8:125::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 02:37:03 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 02:37:03 +0000
Date:   Tue, 26 Sep 2023 21:36:56 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, james.clark@arm.com, james@equiv.tech,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, tglx@linutronix.de
Subject: Re: [RFC PATCH] of: device: Support 2nd sources of probeable but
 undiscoverable devices
Message-ID: <ZROVSAoKF9bimnSP@nixie71>
References: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
 <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com>
 <CAD=FV=WXxGhX0Fw2nSS7PxYb1O-LUewAhoUVPn=2EpbSD2OeHQ@mail.gmail.com>
 <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
 <CAD=FV=UgFzT0TW2WEV0Wmk05EXUad2EYhN2DcckAxE_Lw5gV1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UgFzT0TW2WEV0Wmk05EXUad2EYhN2DcckAxE_Lw5gV1Q@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0151.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::6) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DS0PR08MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 3606e901-ea5c-40d4-9a45-08dbbf02a1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zp8jM8Bb0GFTz9htoZqpcDuc+D78M3c0yL+FL7LHJnMwDdekQu0YzVXIEIuyjMBHliOH0OqEMnYIGcTG5S60UOxqfep4AM55Nuz1D5M6gCvboM2vEVbvxM2uoJZroKCbirb2weV8Go7ukQcpwLFhZ6U0NQCPAM5RkTOUatIEF92YEUdjR31szPX7Gh6g4qh0eT6ZMv59zcRfKiTndEDcpX48PGlHcS0MiHMBylco3xWjLYRunnZrvGmtcIBrcEBWJbNT01oxLcyuRLj+OiRVNBgbrh7Dq1ozhjcigHUYMaDO55b82kIt2jRSCG3xATWl9W0lGKziIjHkT9jqQou6Cx21tmQ3U/KMMDUEs5sFDFPRdeqrnjcoosoCLebJ1Xft3VQaudWhD4vuVu0BXCXBRT5kT2AYKeOSAWFfr2O8KBDz9pRBuv5sJ2f+PDti12rt3l522E8GB+A1aWUYn7VOyLhCsWUtbV2tf7K9re0pxo8aPEZpxmB0ZCIAof200kmGqO42f9fmz3EPQG/zaOdjFcOvgjx9idCSMtmbWHVrb8VI7b/uwvOJWZqUYnBSJM9nZNLIDnsHsq6SxBTLlI055Uyc7wi/s/KAJJRGRgaWrdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(186009)(451199024)(1800799009)(316002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(54906003)(66476007)(66556008)(6916009)(7416002)(66946007)(66899024)(2906002)(53546011)(9686003)(41320700001)(6512007)(6506007)(33716001)(478600001)(6486002)(26005)(83380400001)(86362001)(38100700002)(6666004)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkNWWWduSUpLRHU4bDJuODEyZCtjSFBBQm9pV2djTzJHaEhxNWhjWTcxU25v?=
 =?utf-8?B?RHAycFdvdU5rUkpuRzZML3Y0aVpBaDZHOHhpV1Y2VjZNcjFjd1pIenR5bUE2?=
 =?utf-8?B?ZHB6RGttbi8rZHdUZFJCRENjcW5tTWEvUHc3MDI2TUdFTG9qVnRadW5BSTZl?=
 =?utf-8?B?OC9MdzV6aFcySUZJZnpqK2x6M3RNK3QzaWhFcWpOQ2gvR0Nsd3hXSXZXdHpa?=
 =?utf-8?B?K1BYSnRxNWlnL2x1MjNaZWNuUm5jQ0lKMDVOaHJqN0psSVk1TlZvQzVhVFha?=
 =?utf-8?B?a0todFhQNGdPc2Rqbk9EZ2tldDhFSE00TnN5S0R6MTB5MU9jNTV2NHBWZHpn?=
 =?utf-8?B?UkIrNWFvckROdy9XcDdjZlpXWVlUOS85VHZkWHJWbTdyMmV1SE9xV2prdGth?=
 =?utf-8?B?VHo3cHJyVVAyTlNEVzJXeFFnZlZLcmdYVS9qZ2JxQVJ6NGF2SmhmdUhmL2di?=
 =?utf-8?B?RDhva2lZSEJXY29jLzZzOXdmYWI1UWVUdE1PNXA4NUJqUjUzbHVCZ2FTVWkx?=
 =?utf-8?B?dzcrcUhzQ2hyVDRoblFlMk9UWDJUZStGNmZvdjdoM2tBUmlHcVcrdzF0VVpv?=
 =?utf-8?B?RmFGZDBDMVFoT2tkUWJRTWRrTWE3dW1mbzdjUFY4Vlc0bHlYM3hqVmVscTU4?=
 =?utf-8?B?QlZVM3pBRmlFN1B1MlhGcW8ycEpMU0xXQUxtTzBvaTZRelRxc0FEYXRzT1ZK?=
 =?utf-8?B?Q2FuNVZLNDV1djdoejA1VlY0RGZNa3UycmpBOTgwVHc3Y3YySzJVSzB3K3py?=
 =?utf-8?B?czZnSnZnWmRCeXB3dGpTaGdiUDh1TDVTdkRsbUo4YVpzVC9jWHRZSkRSSytD?=
 =?utf-8?B?WGs5M2VJM1htL1FSYzZ2WFRaVk5Cak9nQS91azdudytMMVowTEhneHFtQXhO?=
 =?utf-8?B?Ni94WVNhM3pFenJ2RmE4MnhtMi9STHFKeFEzT2sxZkRFbHFvLy9JM3B3Yldq?=
 =?utf-8?B?QTU2OXRWaEE5QUZ4UDdqbElHNkJ3K1F1UnZOVFVXVmdWTjREenJSQWJldytR?=
 =?utf-8?B?aDZQODhmZFFKeXlXT3Ryd0VkdGR0VUpQL043czhNOFlKM2RYa2xwNlg3QUhG?=
 =?utf-8?B?M1dMY0tSdGRtSkFhMHFJMkN1enV6VnQ4ejRBM2ROUVl2a3pkYjJpZCt3RVpL?=
 =?utf-8?B?UGxqZnZaWEI5OEFPbGJoVkpJcVdjQUM0UkpvMW0zRWJCUjhmNDdScWZIYnNW?=
 =?utf-8?B?T1pIeGJ4SU9tYnVSdHhwb1dCdm9qcm9uUTQ2QktJdnFQeW4zY3E4N2VQOVVM?=
 =?utf-8?B?eXFvdjF2K21xQW5tZzJGRTB4S3hnaEd5Nk44V0hHZWxQWVRmWUM2S29NWEtG?=
 =?utf-8?B?SzI1cnBLRVNXblFsMEQyTEFpTElwQzVxS3Q1UjVpQ0NLQlM5NkxSdlppWkhV?=
 =?utf-8?B?MzdXSGcxOTlVMFVZdG53Q1g4cnV6bHllWW42VmExZk8vbGx2UVorMGx5ZkNE?=
 =?utf-8?B?ZzdsaUUzbEw2aGVLOTRjMDdnUDRDZXRjb29sbFBHdWh3QUhVSzVTQ1BWdDBL?=
 =?utf-8?B?U3UvSUxucEZxcDZ3OWk1U3l3YkV3K2Faa0pGOGZXbFg2NkNUaVRqQ3JXc3Rn?=
 =?utf-8?B?MWFXaFlaM3BwRnRuVWtUaDFZemhuMGQ5bHk0MC9TVmhnV2wwNVlWbUVUUDh5?=
 =?utf-8?B?K1U1ejNMaEpaU1RSMWZnNHJUQ1diZEZmSVExRlZjbGtzZGdRbDZLaWNVVFd4?=
 =?utf-8?B?TzczdFZXc09CZ2lISGk4NXVqSW9kZXpsVHNINndZUmZtQ3dJV05sVVNpL1h4?=
 =?utf-8?B?YmJCUTFMUVh6TVRob1hYSXVkSFh5WDQyNXQ5WkpJUTZZYld6T0VTT2ZQVmpY?=
 =?utf-8?B?RG1tSTFkMUlQTUlrWXB2Q1BsZFgweHV4dVB4RDJFTkRrVW9aQzhwNWw0c2U2?=
 =?utf-8?B?cjlnMkYyWkN2WFFmQzJyVWFtSHdoSDkxUXkyK09aSGxFem5TMG0vKzRkYU80?=
 =?utf-8?B?SjRSMkNVYktpN2NPbldhcjN2WnpBYXVqSEZPenZOUGZ2NENKTExvZ3NjOERQ?=
 =?utf-8?B?ZCtDUmRLN1lWY3BYclU2ZTlMNkZ4NEtUVnZWM2VQNnlnT0JmN2VXWEIzRTEx?=
 =?utf-8?B?QmNnK1R5NFBWay85NE56TmZvZVVOeGc0OWZMQytDbmpSTEpwblRJYmR5SlJq?=
 =?utf-8?Q?tTYOWlVtCz159UTX6fsJt19Yv?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3606e901-ea5c-40d4-9a45-08dbbf02a1d7
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 02:37:03.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RUEazwv6PFYVmBMmhhfpKxbsG2KLxNMIHeVOA5c/q2OFntUo3AxD47lYL2S+Jt0eDoZfMG6VBjgUSYPUGgaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB8489
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Fri, Sep 22, 2023 at 05:11:10PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Sep 22, 2023 at 12:08 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > > > This seems like overkill to me. Do we really need groups and a mutex
> > > > for each group? Worst case is what? 2-3 groups of 2-3 devices?
> > > > Instead, what about extending "status" with another value
> > > > ("fail-needs-probe"? (fail-xxx is a documented value)). Currently, the
> > > > kernel would just ignore nodes with that status. Then we can process
> > > > those nodes separately 1-by-1.
> > >
> > > My worry here is that this has the potential to impact boot speed in a
> > > non-trivial way. While trackpads and touchscreens _are_ probable,
> > > their probe routines are often quite slow. This is even mentioned in
> > > Dmitry's initial patches adding async probe to the kernel. See commit
> > > 765230b5f084 ("driver-core: add asynchronous probing support for
> > > drivers") where he specifically brings up input devices as examples.

Ideally, all but one driver in a group should bail out of probe quickly if
the device is not populated. If not, I would consider that to be a bug or at
least room for improvement in that driver.

The reason input devices can take a while to probe is because they may be
loading FW over I2C or performing some sort of calibration procedure; only
one driver in the group should get that far.

> >
> > Perhaps then this should be solved in userspace where it can learn
> > which device is actually present and save that information for
> > subsequent boots.
> 
> Yeah, the thought occurred to me as well. I think there are a few
> problems, though:
> 
> a) Userspace can't itself probe these devices effectively. While
> userspace could turn on GPIOs manually and query the i2c bus manually,
> it can't (I believe) turn on regulators nor can it turn on clocks, if
> they are needed. About the best userspace could do would be to blindly
> try binding an existing kernel driver, and in that case why did we
> need userspace involved anyway?
> 
> b) While deferring to userspace can work for solutions like ChromeOS
> or Android where it's easy to ensure the userspace bits are there,
> it's less appealing as a general solution. I think in Johan's case
> he's taking a laptop that initially ran Windows and then is trying to
> run a generic Linux distro on it. For anyone in a similar situation,
> they'd either need to pick a Linux distro that has the magic userspace
> bits that are needed or they need to know that, on their laptop, they
> need to manually install some software. While requiring special
> userspace might make sense if you've got a special peripheral, like an
> LTE modem, it makes less sense to need special userspace just to get
> the right devices bound...

I recommend against spilling the solution into user space; it's simply not
practical for many downstream use-cases where platform engineers can tightly
control their own bootloader and kernel, but have limited maintainership of
user space which is likely to be shared by many other products.

> 
> 
> > > It wouldn't be absurd to have a system that has multiple sources for
> > > both the trackpad and the touchscreen. If we have to probe each of
> > > these one at a time then it could be slow. It would be quicker to be
> > > able to probe the trackpads (one at a time) at the same time we're
> > > probing the touchscreens (one at a time). Using the "fail-needs-probe"
> > > doesn't provide information needed to know which devices conflict with
> > > each other.
> >
> > I would guess most of the time that's pretty evident. They are going
> > to be on the same bus/link. If unrelated devices are on the same bus,
> > then that's going to get serialized anyways (if bus accesses are what
> > make things slow).

Agreed with Rob here; in the case of a touchscreen, we're almost always
dealing with a module that connects to the main board by way of a flex
connector. Rarely do the bus and GPIO assignments change across alternates.

> >
> > We could add information on the class of device. touchscreen and
> > touchpad aliases or something.
> 
> Ah, I see. So something like "fail-needs-probe-<class>". The
> touchscreens could have "fail-needs-probe-touchscreen" and the
> trackpads could have "fail-needs-probe-trackpad" ? That could work. In
> theory that could fall back to the same solution of grabbing a mutex
> based on the group ID...
> 
> Also: if having the mutex in the "struct device" is seen as a bad
> idea, it would also be easy to remove. __driver_probe_device() could
> just make a call like "of_device_probe_start()" at the beginning that
> locks the mutex and then "of_device_probe_end()" that unlocks it. Both
> of those calls could easily lookup the mutex in a list, which would
> get rid of the need to store it in the "struct device".
> 
> 
> > > That would lead me to suggest this:
> > >
> > >   &i2c_bus {
> > >     trackpad-prober {
> > >       compatible = "mt8173-elm-hana-trackpad-prober";
> > >
> > >       tp1: trackpad@10 {
> > >         compatible = "hid-over-i2c";
> > >         reg = <0x10>;
> > >         ...
> > >         post-power-on-delay-ms = <200>;
> > >       };
> > >       tp2: trackpad@20 {
> > >         compatible = "hid-over-i2c";
> > >         reg = <0x20>;
> > >         ...
> > >         post-power-on-delay-ms = <200>;
> > >       };
> > >     };
> > >   };
> > >
> > > ...but I suspect that would be insta-NAKed because it's creating a
> > > completely virtual device ("mt8173-elm-hana-trackpad-prober") in the
> > > device tree. I don't know if there's something that's functionally
> > > similar that would be OK?

This solution seems a bit confusing to me, and would require more edits
to the dts each time a second source is added. It also means one would
have to write a small platform driver for each group of devices, correct?
I like the idea of a new "status" string; just my $.02.

> >
> > Why do you need the intermediate node other than a convenient way to
> > instantiate a driver? You just need a flag in each node which needs
> > this special handling. Again, "status" could work well here since it
> > keeps the normal probe from happening. But I'm not saying you can't
> > have some board specific code. Sometimes you just need code to deal
> > with this stuff. Don't try to parameterize everything to DT
> > properties.
> 
> I think I'd have an easier time understanding if I knew where you
> envisioned the board-specific code living. Do you have an example of
> board specific code running at boot time in the kernel on DT systems?
> 
> 
> > Note that the above only works with "generic" compatibles with
> > "generic" power sequencing properties (I won't repeat my dislike
> > again).
> 
> I don't think so? I was imagining that we'd have some board specific
> code that ran that knew all the possible combinations of devices,
> could probe them, and then could instantiate the correct driver.
> 
> Imagine that instead of the hated "hid-over-i2c" compatible we were
> using two other devices. Imagine that a given board could have a
> "elan,ekth6915" and a "goodix,gt7375p". Both of these devices have
> specific timing requirements on how to sequence their supplies and
> reset GPIOs. For Elan we power on the supplies, wait at least 1 ms,
> deassert reset, wait at least 300 ms, and then can talk i2c. For
> Goodix we power on the supply, wait at least 10 ms, deassert reset,
> wait at least 180 ms, and then can talk i2c. If we had a
> board-specific probing driver then it would power on the supplies,
> wait at least 10 ms (the max of the two), deassert reset, wait at
> least 300 ms (the max of the two), and then see which device talked.
> Then it would instantiate whichever of the two drivers. This could be
> done for any two devices that EEs have determined have "compatible"
> probing sequences.
> 
> Ideally in the above situation we'd be able to avoid turning the
> device off and on again between the board-specific probe code and the
> normal driver. That optimization might need special code per-driver
> but it feels doable by passing some sort of hint to the child driver
> when it's instantiated.
> 
> 
> > If only the driver knows how to handle the device, then you
> > still just have to have the driver probe. If you *only* wanted to
> > solve the above case, I'd just make "hid-over-i2c" take a 2nd (and
> > 3rd) I2C address in reg and have those as fallbacks.
> 
> Yeah, it did occur to me that having "hid-over-i2c" take more than one
> register (and I guess more than one "hid-descr-addr") would work in my
> earlier example and this might actually be a good solution for Johan.
> I'm hoping for a better generic solution, though.
> 
> 
> > You could always make the driver probe smarter where if your supply
> > was already powered on, then don't delay. Then something else could
> > ensure that the supply is enabled. I'm not sure if regulators have the
> > same issue as clocks where the clock might be on from the bootloader,
> > then a failed probe which gets then puts the clock turns it off.
> 
> I'm not sure it's that simple. Even if the supply didn't turn off by
> itself in some cases, we wouldn't know how long the supply was on.
> 
> -Doug

Thanks for charting this path; I'm really excited to see a solution to
this common problem.

Kind regards,
Jeff LaBundy
