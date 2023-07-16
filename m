Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40B47550AA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGPSsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGPSsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:48:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E35B1B6;
        Sun, 16 Jul 2023 11:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USs6QbggMLCfmHd+0bKG8N9ZN61hYH5OQJ32EhVa1XN2Hc8AXcB8AEKPCBGP5ex4hgM9nRyHFKFiySpSkDju87tYQKOJrEmDvXfAK5rqpsLZrt025o2fZMnDIM9p2G034Y2gP8HZpmIiTB363q2mI6LaCKft7NAad0U/eLhAlrzarFpsTbBn0nvXS8qcMeCIhXxuO1+eW+uoFAPFXtwsT+VHk9RM2OiE9xdyXohbtxq1UxDhXPwkarvToee7vWKWEsluKBBXtY8l78U3qcKZPuiGp5HWwqD0/gYkzM4650cJo1q3E6OM7LzAbeCauYFBK3lQuKdwB9ujC7oSHbgS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9ssFtvhQq7c+DujNZ+hJJIlGpN2akyLL7xbURZ2Ptg=;
 b=AhZv3oyD0cbcQC3w8+La0Sno4UknUV+WtZRqOZ+gcc3k/1PyLQcMNyn9nielju9moaf6e6NKxKSJr+alvAbnYojrk9+72j7/Xh25bGNyDpeztmnIJ02VYh5sGgIxf2HK0xIMkQHbQYVZFSuIH9Zzy8spR0RV3vqIiw6x45+bSuz1vzcE1+8oCq2lQYaRboPjz0224oxIa0j1E+I7e+g9BunY/UhPPHP9OGO5yImGnwRNA235qYu/OFwWYFkVqFJFZtem71Zsi+KYlaSEkhQ+Y+s+60L1z/ROALzaNvd7FX8MkIbwVqsrX53+vvXfAiB/79DawycA801WLbVdxDxU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9ssFtvhQq7c+DujNZ+hJJIlGpN2akyLL7xbURZ2Ptg=;
 b=f7h/ZL9B4Ub++9Wf6a+MtHsTwHySlbkyYYhaJtC86dBtYboKFDFytocQPa+6n3pSWL+sv0U0Q48q5/enSWWZz9egQ+mKoCcS5ebXu0euVN7V2N6L3SSKNoe6iloAIN4AThO4XEwZ7v0VPaZx5MHe4DJ30EJxqyFCSG1mfpnYCyvXte6IPldFjy3b/+/fjCGHn5tNsjMsTdz6wfIzg0Fmv7rw7k2SRz6ke4Wq8AAdlVyBDRRDBdE3Qv52akav4rVcKv8AbgtL5v/LT/TLdI5dsh7MvK+E9KRpnBPdZQxix6khHvp0CfLftJFnV4rXkUg1l4tFOrs8V1lUI/dv7m40IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 18:48:07 +0000
Received: from BN7PR12MB2740.namprd12.prod.outlook.com
 ([fe80::d658:fc9e:6893:bd6]) by BN7PR12MB2740.namprd12.prod.outlook.com
 ([fe80::d658:fc9e:6893:bd6%3]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 18:48:06 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: hid-google-stadiaff: add support for Stadia
 force feedback
References: <20230709214410.3676224-1-fabiobaltieri@chromium.org>
        <878rbidwn5.fsf@nvidia.com> <ZLQ5XMobES0r6Fel@google.com>
Date:   Sun, 16 Jul 2023 11:47:53 -0700
In-Reply-To: <ZLQ5XMobES0r6Fel@google.com> (Fabio Baltieri's message of "Sun,
        16 Jul 2023 18:39:24 +0000")
Message-ID: <87zg3vr8va.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To BN7PR12MB2740.namprd12.prod.outlook.com
 (2603:10b6:408:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: e080de3e-47d9-4519-339d-08db862d3142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hq8EF5PSd7aTYqdBgSDYIaSQH3dWYua3NEy8M6+3NqMuSUa7Wt8KvDFa+fasOZ0RDK1gOwMmfB+NUpnxF/018DRT6exmtMrN2Hk16mZidape/QDbgQzI6nomXWXGUljw84CXzWt0aQH2muvybEtMqYUfVnV2io6QS34AWpI6HqG1fdyNTYUcqaeb4BRiZAF93k3kLCUCXpJAPfnVn7pVAN/1LZ/UprYEPEbGO0gFzfCY1W2pn4EMaXZLPoRrx7pmAJyvsvstKDogmbOouF+MxGHbXsVR9gNJnrtn4ROLTv5Ym4FxGSBrs7gKylLtczwwGgaZM3xeXMb0dsRSm8hp03bW1a063vAGTn5qVs6hGHyHCP96eEU9LngdZNp0s9igjlCff3GJ0/6Ma0JePKPHpTIDHuObQ02M0zGp+rZn2dwVuWWMlakJ/vk5B356Mdc/7LFAVA7n5KEgM90g9FqIVDGqGgLoHLPhEJZCstZPqZQtCvS6sz3PMVZ3988Sl4j+iYAfwn/RkUDaODjuwgBBIoCXfAQR0voPH6LALhqB+T8mjV4XiWq30Bo3EeCw8bZ6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2740.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(478600001)(6486002)(6666004)(54906003)(186003)(6506007)(36756003)(26005)(6512007)(2906002)(316002)(41300700001)(6916009)(4326008)(66946007)(66476007)(5660300002)(8936002)(8676002)(66556008)(38100700002)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ie46plRmAafgYEvYGpjQG52qOUpS+ErqAl0C+sm+A6OPTEACy/Dg3kV4f2He?=
 =?us-ascii?Q?laOhz24rCebi5jxJjSlcC+fL27nskhj0m4ZhIr4jQpRoK/ZHrwNZGB+9GaFJ?=
 =?us-ascii?Q?L9XquZgL7UqjFabawA8jTtAG/djnX0Kl51WMRHRiI76QG0OKRlwT3O+HH7H+?=
 =?us-ascii?Q?9mC18FoG6/m5Rgu0T2xiLNThyFBiGg0AYAQauK6BxRqmG+X6AU8O7lQ8ja8J?=
 =?us-ascii?Q?tghp7Y1Ah6zKznnkjehWP1C8IERzpEdBWNp4LjifGGgbB1ht13kECs2EIGnl?=
 =?us-ascii?Q?rT45yxmBF6eNzUbJzy/JnZ5l+fWGVz5f0OuR8hr9Z5h6eUgnHX0p8N2kk1pn?=
 =?us-ascii?Q?gndx24SO4/6wGqgsJUKzG2fdr2JRiMk+FraF/pMC6v1GhViGezrITc7IIOaN?=
 =?us-ascii?Q?pWVzewjWk4lznP/2TvkhF7g4lmzb6RW5XK+kgQuCQZYg1DvmH1KWxPJ6HQnt?=
 =?us-ascii?Q?0hztyFPlgCbmmqs+VIHBFUTZPMHB7VFgolUt1ONDorzbk0sZRTyxTtfHRJwW?=
 =?us-ascii?Q?+dO7AHMEgJ+Gx+lYnULGOY5XzbY+1tI35c1HE7QAJWOwjbxoYPGt3dTN+oUJ?=
 =?us-ascii?Q?gxkIwLZdGd5EhsFj2xDFmOkd0deIhwXUNBRXQ3IiIuTPUJdkHacURyqU0ftI?=
 =?us-ascii?Q?7/LTypQIf8WoCHqwWhDutexlItfAzGwMycwaDXV79KQUn8hrAH7QM4sqqmRF?=
 =?us-ascii?Q?xj59L90G572fcM1tnTUaiNyHDNHyuyorpVjA89OVAioLr05e+073PVyrCtgV?=
 =?us-ascii?Q?zqmlZluY7gKphJwApdfBjiOIi0zd2GOU8MFciWh78DUFqyfqwWvP7k13xiXv?=
 =?us-ascii?Q?YYV29GHnvYj/TL5iBrSpaSpqyTbKjiRoDjy6myl2IZVFOjX6cSi4wXaRChFT?=
 =?us-ascii?Q?53T/Pcj1k5aoCOrn/7+AVhYSdZvgJZytXnQc/jpwX+GMlbX0i8NmshXvOXCx?=
 =?us-ascii?Q?PgDBN9LGHwncUx4KYwxyp7WHRBDo1Z81TfsDoP66HjEdO8bmbzEh9DgddQYk?=
 =?us-ascii?Q?eyJkVZ+/5+pNdy7abUgVTaE4BAPjd60co1+E/RJWpKZdqSbK+L5/sShqHpJX?=
 =?us-ascii?Q?nWRyEfvG+4pJCpILxMzMolY8/Vl5/9GQiLdSnZ4yOLaGLBbjLkYnl/vgfWV9?=
 =?us-ascii?Q?svmpZ7a0hsKqSgSB01Zbmt3adFsNApfGIMdbCQvQn3xf7V9jr/Kyh2ulwGtT?=
 =?us-ascii?Q?CM8I2Aizdy+1BTPStGFPnsOc/qugLNhlMkZiYoeRZwIMFAHCf9CBF7GIUUIQ?=
 =?us-ascii?Q?4t+VBfeIao+hzIBLbpLvaJVWt/8uviWlyFuwkBRzeUy3R5AiWpzqrEKfO1GF?=
 =?us-ascii?Q?O6IynYMF6zv6H6Lr6nspm43SFSNKmkaxStLVBJ3OFzaQHu52Eg2k1bddIJ2m?=
 =?us-ascii?Q?X+tRuRscsTndS5iG7uOYlvWJskdgY1clK6T9qGhKhCUAYBjH1GgIZNpX+XMg?=
 =?us-ascii?Q?X5HvouNWVfHAfXfmfxUgm9mj22UNGwtYQlGWCN6yFsFaQfVUPN7jd9XQ0tAW?=
 =?us-ascii?Q?S5czBaPtn7dMZ7VHDixPXPriRnJQvapaVHMNXX7ACQ7ng+DkCDO5ZwZEiBgA?=
 =?us-ascii?Q?dKFOq/vgNbGY+sLeTdTmS1T8y1F03n5QrHCuV4JVnbprZ7QCrzKzL4Vn6Q1C?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e080de3e-47d9-4519-339d-08db862d3142
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2740.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 18:48:06.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBR/khCxNj8zlSDqQwJNHaYx5cxv98eaaVw84kpZz6836IkLBCyyg8J2CMo7oCbfsCv00b+FaSItUABtdVqPkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul, 2023 18:39:24 +0000 Fabio Baltieri <fabiobaltieri@chromium.org> wrote:
> Hi Rahul,
>
> On Fri, Jul 14, 2023 at 02:13:34PM -0700, Rahul Rameshbabu wrote:
>> On Sun, 09 Jul, 2023 21:44:10 +0000 Fabio Baltieri <fabiobaltieri@chromium.org> wrote:
>> > Add a hid-stadiaff module to support rumble based force feedback on the
>> > Google Stadia controller. This works using the HID output endpoint
>> > exposed on both the USB and BLE interface.
>> >
>> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
>> > ---
>> > +static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
>> > +{
>> > +	int ret;
>> > +
>> > +	ret = hid_parse(hdev);
>> > +	if (ret) {
>> > +		hid_err(hdev, "parse failed\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
>> > +	if (ret) {
>> > +		hid_err(hdev, "hw start failed\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	ret = stadiaff_init(hdev);
>> > +	if (ret) {
>> > +		dev_err(&hdev->dev, "force feedback init failed\n");
>> 
>> Error handling looks good to me now. Is there any particular reason you
>> use dev_err here instead of hid_err here?
>
> Not really, copied from another hid driver and did not realize the
> inconsistency. I'll fix that up and send a v4.
>
> Thanks again for spotting this!

No worries. Btw, in your commit message body, you might want to change
hid-stadiaff to hid-google-stadiaff as well for your v4 submission.

Thanks,

-- Rahul Rameshbabu
